# == Schema Information
#
# Table name: student_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  course_id  :integer          not null
#  faculty_id :integer
#

FactoryGirl.define do
  factory :student_group, class: StudentGroup do
    sequence(:name) {|n| "Group_#{n}" }
    course { StudentCourse.first || create(:student_course) }
    faculty { Faculty.first || create(:faculty) }
  end

end
