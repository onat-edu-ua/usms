class Hostel < ActiveRecord::Base

  self.table_name='hostels'

  has_paper_trail :class_name => 'AuditLog'

  def display_name
    "#{self.name}"
  end

  def self.collection
    order(:name)
  end

end