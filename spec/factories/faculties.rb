FactoryGirl.define do
  factory :faculty, class: Faculty do
    sequence(:name) {|n| "Faculty_#{n}" }
  end

end
