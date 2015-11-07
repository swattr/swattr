FactoryGirl.define do
  factory :comment, class: Swattr::Comment do
    author
    issue
    body "Amazing, thoughtful comment"
  end
end
