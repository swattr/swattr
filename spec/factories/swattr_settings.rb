FactoryGirl.define do
  factory :setting, aliases: [:settings], class: Swattr::Setting do
    title "Swattr"
    per_page 24
  end
end
