class Student < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'



  belongs_to :group,:class_name => StudentGroup,:foreign_key => :group_id
  validates_presence_of :first_name,:last_name,:group
  validates_format_of :email, :with => /(.*)@(.*)/



  def display_name
    "#{self.first_name}"
  end

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
  end

  def display_name
    "#{self.last_name} #{self.first_name} #{self.middle_name}"
  end

end