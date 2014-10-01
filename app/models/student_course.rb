class StudentCourse < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'

  def display_name
    "#{self.name}"
  end
end