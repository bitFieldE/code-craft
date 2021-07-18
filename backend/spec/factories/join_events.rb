FactoryBot.define do
  factory :join_event do
    association :user
    association :event
  end
end
