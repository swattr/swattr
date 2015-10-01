FactoryGirl.define do
  factory :issue_tag, class: Swattr::IssueTag do
    issue
    tag
  end
end
