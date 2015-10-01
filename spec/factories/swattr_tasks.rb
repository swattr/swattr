FactoryGirl.define do
  factory :task, class: Swattr::Task do
    sequence(:title) { |n| "Issue task #{n}" }
    issue
    association :author, factory: :user
    position 0
  end
end
