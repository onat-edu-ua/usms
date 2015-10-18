# == Schema Information
#
# Table name: student_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  course_id  :integer          not null
#  faculty_id :integer
#

class StudentGroup < ActiveRecord::Base

  has_paper_trail :class_name => 'AuditLog'


  validates_presence_of :name, :course, :faculty
  validates_uniqueness_of :name
  belongs_to :faculty, class_name: Faculty, foreign_key: :faculty_id
  belongs_to :course, class_name: StudentCourse, foreign_key: :course_id

  def display_name
    "#{course.name}-#{self.name}"
  end

  def self.collection
    order(:name)
  end

  def name=(nm)
    self[:name] = nm.strip
  end

end
