FactoryGirl.define do
  factory :project, class: Swattr::Project do
    sequence(:name) { |n| "Project #{n}" }
    sequence(:slug) { |n| "project-#{n}" }
    location "http://www.example.com/"
    author
  end
end
