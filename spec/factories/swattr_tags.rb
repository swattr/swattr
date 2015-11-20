FactoryGirl.define do
  factory :tag, class: Swattr::Tag do
    sequence(:name) { |n| "Tag #{n}" }
    sequence(:slug) { |n| "tag-#{n}" }
    color "#ff00ff"
    position 0
  end
end
