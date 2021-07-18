FactoryBot.define do
  factory :event_comment do
    association :user
    association :event
    content { Faker::Lorem.sentence }
  end
end
