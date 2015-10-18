# == Schema Information
#
# Table name: hostels
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         default(2015-10-15 21:01:28 UTC), not null
#  updated_at :datetime
#

class Hostel < ActiveRecord::Base

  self.table_name='hostels'
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
