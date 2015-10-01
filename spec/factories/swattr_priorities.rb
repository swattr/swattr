FactoryGirl.define do
  factory :priority, class: Swattr::Priority do
    sequence(:name) { |n| "Priority #{n}" }
    position 0
  end
end
