# == Schema Information
#
# Table name: student_courses
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class StudentCourse < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'

  def display_name
    "#{self.name}"
  end

  def self.collection
    order(:name)
  end

end
