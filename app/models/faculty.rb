class Faculty < ActiveRecord::Base

  self.table_name='faculties'

  has_paper_trail :class_name => 'AuditLog'

  def display_name
    "#{self.name}"
  end

  def self.collection
    order(:name)
  end

end