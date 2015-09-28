class Student < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'

  belongs_to :group, class_name: StudentGroup, foreign_key: :group_id
  belongs_to :hostel, class_name: Hostel, foreign_key: :hostel_id
  has_many :documents, class_name: StudentUploadedDocument, foreign_key: :student_id

  validates_presence_of :first_name, :last_name, :group
  validates_format_of :email, with: /(.*)@(.*)/, allow_nil: true, allow_blank: true #TODO fix regexp
  validates_format_of :phone, with: /0(.*)/, allow_nil: true, allow_blank: true #TODO fix regexp
  validates_uniqueness_of :ticket_num, :email


  after_create do
    delay.samba_sync
  end

  after_update do
    delay.samba_sync
  end

  def roles_list
    roles.map(&:name).join(",")
  end

  def roles
    @r ||= StudentRole.where(id: role_id)
  end

  validate do
    if self.role_id.present? and self.role_id.any?
      self.errors.add(:role_id, :invalid) if roles.count != self.role_id.count
    end
  end


  def role_id=(role_ids) # removing zero element from array
    self[:role_id] = role_ids.reject { |i| i.blank? }
  end

  def first_name=(nm)
    self[:first_name] = nm.strip
  end

  def last_name=(nm)
    self[:last_name] = nm.strip
  end

  def middle_name=(nm)
    self[:middle_name] = nm.strip
  end

  def email=(nm)
    self[:email] = nm.strip
  end

  def ticket_num=(nm)
    self[:ticket_num] = nm.strip
  end

  def phone=(nm)
    self[:phone] = nm.strip
  end


  scope :role_in, ->(*ids) { where("role_id @>ARRAY[?]", ids.to_a.map(&:to_i)) }
  scope :fio_contains, ->(name) { where("last_name||first_name||COALESCE(middle_name) ilike ?", "%#{name}%") }

  before_create do
    ActiveRecord::Base.connection.execute("LOCK TABLE students") # need for unique login generation
    self.login=generate_login
    self.password=generate_password
  end

  def generate_login
    @start_try=Translit.convert(self.last_name, :english).downcase << "." << Translit.convert(self.first_name, :english)[0].downcase
    ## check if username already exists
    @try=@start_try
    for i in 1..100
      st=Student.find_by login: @try
      if st.nil?
        break
      end
      @try=@start_try+i.to_s
      #TODO raise exception if no success after 100 attempts
    end
    @try
  end

  def generate_password
    SecureRandom.urlsafe_base64(5, false)
  end


  def display_name
    "#{self.last_name} #{self.first_name} #{self.middle_name}"
  end

  def samba_sync
    user=Backend::SambaUser.new(
        id: id,
        login: login,
        display_name: display_name,
        first_name: first_name,
        last_name: last_name,
        phone: phone,
        email: email,
        password: password
    )
    user.sync
  end

  private

  def self.ransackable_scopes(auth_object = nil)
    [
        :role_in,
        :fio_contains
    ]
  end

end