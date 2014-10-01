class Student < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'

  belongs_to :group,:class_name => StudentGroup,:foreign_key => :group_id
  belongs_to :role,:class_name => StudentRole,:foreign_key => :role_id
  has_many :documents,:class_name => StudentUploadedDocument,:foreign_key => :student_id

  validates_presence_of :first_name,:last_name,:group
  validates_format_of :email, :with => /(.*)@(.*)/


  def create_or_update
    transaction do
      ActiveRecord::Base.connection.execute("LOCK TABLE students")

      if self.new_record?
        self.password=SecureRandom.urlsafe_base64(5,false)
        @start_try=Translit.convert(self.last_name, :english).downcase << "." << Translit.convert(self.first_name, :english)[0].downcase

        ## check if username already exists
        @try=@start_try
        for i in 1..100
          st=Student.find_by login: @try
          if st.nil?
            break
          end
          @try=@start_try+i.to_s
        end
        self.login=@try
      end
      super
    end
    self.delay.ad_sync
  end

  def display_name
    "#{self.last_name} #{self.first_name} #{self.middle_name}"
  end

  def ad_sync
    ad = RADUM::AD.new :root => 'dc=test,dc=onat,dc=edu,dc=ua',
                    :user => 'cn=Administrator,cn=Users',
                    :password => '1yoyP23wru3hdgd',
                    :server => '10.4.1.101'

    cont=ad.find_container('cn=Users')
    ad.load
    user = RADUM::User.new :username => self.login,:container=>cont , :primary_group=>ad.find_group_by_name('Domain Users')
    ad.sync

  end

end