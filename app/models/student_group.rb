class StudentGroup < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'


  validates_presence_of :name,:course
  belongs_to :course, :class_name => StudentCourse,:foreign_key => :course_id

  def display_name
    "#{self.name}"
  end
end