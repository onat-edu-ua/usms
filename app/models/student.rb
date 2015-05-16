class Student < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'

  belongs_to :group, class_name: StudentGroup, foreign_key: :group_id
  belongs_to :hostel, class_name: Hostel, foreign_key: :hostel_id
  has_many :documents, class_name: StudentUploadedDocument, foreign_key: :student_id

  validates_presence_of :first_name, :last_name, :group
  validates_format_of :email, :with => /(.*)@(.*)/


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
    self[:role_id] = role_ids.reject {|i| i.blank? }
  end





  scope :role_in, ->(*ids) { where("role_id @>ARRAY[?]", ids.to_a.map(&:to_i)) }
  scope :fio_contains, ->(name) { where("last_name||first_name||COALESCE(middle_name) ilike ?", "%#{name}%") }

  before_create do
    ActiveRecord::Base.connection.execute("LOCK TABLE students") # need for unique login generation
    self.login=generate_login
    self.password=generate_password
  end

  after_create do
    delay.ldap_sync
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
    SecureRandom.urlsafe_base64(5,false)
  end


  def display_name
    "#{self.last_name} #{self.first_name} #{self.middle_name}"
  end

  def ldap_sync
    ad = RADUM::AD.new :root => 'dc=test,dc=onat,dc=edu,dc=ua',
                    :user => 'cn=Administrator,cn=Users',
                    :password => '1yoyP23wru3hdgd',
                    :server => '10.4.1.101'

    cont=ad.find_container('cn=Users')
    ad.load

    user = ad.find_user_by_username(self.login)
    unless user.nil?
      user.password=self.password
      user.mail=self.email
      user.telephone_number=self.phone
      user.first_name=self.first_name
      user.middle_name=self.middle_name
      user.surname=self.last_name
      ad.sync
    else
      user = RADUM::User.new :username => self.login,
                           #:rid=>self.id,
                           :container=>cont ,
                           :primary_group=>ad.find_group_by_name('Domain Users'),
                           :password=> self.password
      ad.sync
      self.ad_sync # fucking recursion
    end


   # user = User.find("Administrator")
    #puts user

    # ldap = Net::LDAP.new
    # ldap.host = "10.4.1.101"
    # ldap.port = 389
    # ldap.authenticate "Administrator", "1yoyP23wru3hdgd"
    #
    # dn = "cn=#{self.login}, dc=test, dc=onat, dc=edu, dc=ua"
    #
    # attr = {
    #     :cn => self.login,
    #     :password => self.password,
    #     :objectclass => "User",
    #     :sn => self.login,
    #     :telephoneNumber => self.phone,
    #     :mail => self.email
    # }
    # ldap.add(:dn => dn, :attributes => attr)

  end

  private

    def self.ransackable_scopes(auth_object = nil)
    [
        :role_in,
        :fio_contains
    ]
  end

end