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