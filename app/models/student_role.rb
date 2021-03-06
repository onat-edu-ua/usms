# == Schema Information
#
# Table name: student_roles
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class StudentRole < ActiveRecord::Base
  has_paper_trail :class_name => 'AuditLog'

  validates_presence_of :name
  validates_uniqueness_of :name

  def display_name
    "#{self.name}"
  end

  def self.collection
    order(:name)
  end

  def name=(nm)
    self[:name] = nm.strip
  end

end
