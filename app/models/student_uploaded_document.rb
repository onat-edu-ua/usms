# == Schema Information
#
# Table name: student_uploaded_documents
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  filename   :string(255)      not null
#  data       :binary
#  created_at :datetime
#  updated_at :datetime
#  student_id :integer          not null
#

class StudentUploadedDocument < ActiveRecord::Base

  self.table_name='student_uploaded_documents'
  belongs_to :student, :class_name => Student, :foreign_key => :student_id
  validates_presence_of :name, :filename, :student
#  attribute_accessor :file

  def display_name
    "#{self.filename}"
  end

  def student_file=(uploaded_file)
    self.filename = uploaded_file.original_filename

    pp=uploaded_file.read
    p pp
    self.data = pp.to_s
    #p ufile.read
    #self.sha1=Digest::SHA1.hexdigest(self.data)
  end

end
