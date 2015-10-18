# == Schema Information
#
# Table name: students
#
#  id              :integer          not null, primary key
#  first_name      :string(255)      not null
#  last_name       :string(255)      not null
#  middle_name     :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  ticket_num      :string(255)
#  login           :string(255)
#  password        :string(255)
#  group_id        :integer
#  phone           :string(255)
#  email           :string(255)
#  role_id         :integer          is an Array
#  hostel_id       :integer
#  hostel_room     :string(255)
#  parents_address :string(255)
#  parents_phone   :string(255)
#  parents         :string(255)
#

class Remote::Student < ActiveResource::Base
  self.site = USMS_CONFIG[:api][:url]

  def full_name
    "#{first_name} #{last_name}"
  end
end
