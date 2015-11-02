FactoryGirl.define do
  factory :task, class: Swattr::Task do
    sequence(:title) { |n| "Issue task #{n}" }
    issue
    author
    position 0

    trait :deleted do
      deleted_at { Time.current }
      deleted_by { author }
    end
  end
end
