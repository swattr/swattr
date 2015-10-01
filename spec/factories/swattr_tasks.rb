FactoryGirl.define do
  factory :task, class: Swattr::Task do
    sequence(:title) { |n| "Issue task #{n}" }
    issue
    author
    position 0
  end
end
