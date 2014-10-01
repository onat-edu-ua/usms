class StudentRole < ActiveRecord::Base
  has_paper_trail :class_name => 'AuditLog'

  validates_presence_of :name

  def display_name
    "#{self.name}"
  end
end