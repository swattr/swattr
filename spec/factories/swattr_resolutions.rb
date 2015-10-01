FactoryGirl.define do
  factory :resolution, class: Swattr::Resolution do
    sequence(:name) { |n| "Resolution #{n}" }
    position 0
  end
end
