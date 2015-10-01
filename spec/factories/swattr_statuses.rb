FactoryGirl.define do
  factory :status, class: Swattr::Status do
    sequence(:name) { |n| "Status #{n}" }
    position 0
  end
end
