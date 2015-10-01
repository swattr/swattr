FactoryGirl.define do
  factory :issue, class: Swattr::Issue do
    sequence(:title) { |n| "Issue #{n}" }
    content "Content of issue."
    project
    association :author, factory: :user
    priority
    status

    trait :resolved do
      resolution
    end

    trait :assigned do
      association :assignee, factory: :user
    end

    trait :past_due do
      due_at { 1.week.ago }
    end

    trait :with_tasks do
      transient do
        task_count 3
      end

      after(:create) do |issue, evaluator|
        create_list(:task, evaluator.task_count, issue: issue)
      end
    end

    trait :with_tags do
      transient do
        tag_count 3
      end

      after(:create) do |issue, evaluator|
        tag = create(:tag)

        create_list(:issue_tag, evaluator.tag_count, issue: issue, tag: tag)
      end
    end
  end
end
