FactoryGirl.define do
  factory :project, class: Swattr::Project do
    sequence(:name) { |n| "Project #{n}" }
    sequence(:slug) { |n| "project-#{n}" }
    location "http://www.example.com/"
    association :author, factory: :user
    association :owner, factory: :user
  end
end
