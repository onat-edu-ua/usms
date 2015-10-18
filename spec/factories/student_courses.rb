FactoryGirl.define do
  factory :student_course, class: StudentCourse do
    sequence(:name) {|n| "Course_#{n}" }
  end

end
