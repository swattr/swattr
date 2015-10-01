FactoryGirl.define do
  factory :tag, class: Swattr::Tag do
    sequence(:name) { |n| "Tag #{n}" }
    color "#ff00ff"
    position 0
  end
end
