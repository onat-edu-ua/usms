class Student < ActiveRecord::Base

  #validates_presence_of
#  attr_accessible :first_name, :last_name, :middle_name
  #permit_params :first_name, :last_name, :middle_name

  def display_name
    "#{self.first_name}"
  end
end