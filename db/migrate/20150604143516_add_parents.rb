class AddParents < ActiveRecord::Migration
  def self.up
    execute("Alter table students add parents varchar;")
  end

  def self.down
    execute("Alter table students drop column parents;")
  end

end
