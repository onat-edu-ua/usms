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

end