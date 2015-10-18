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

FactoryGirl.define do
  factory :student, class: Student do
    sequence(:first_name) {|n| "John_#{n}"}
    last_name "Doe"
    # sequence(:login) {|n| "john.doe#{n}" }
    sequence(:email) {|n| "john.doe#{n}@rspec.com"}
    password "testpassword"
    group { StudentGroup.first || create(:student_group) }
  end

end
