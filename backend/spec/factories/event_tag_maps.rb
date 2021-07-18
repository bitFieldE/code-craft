FactoryBot.define do
  factory :event_tag_map do
    association :event
    association :tag
  end
end
