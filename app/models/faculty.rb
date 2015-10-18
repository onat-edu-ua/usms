# == Schema Information
#
# Table name: faculties
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         now(), not null
#  updated_at :datetime
#

class Faculty < ActiveRecord::Base

  self.table_name='faculties'

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
