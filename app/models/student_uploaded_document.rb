class StudentUploadedDocument < ActiveRecord::Base

  belongs_to :student, :class_name => Student,:foreign_key => :student_id
  validates_presence_of :name,:filename,:student

  def display_name
    "#{self.filename}"
  end
end