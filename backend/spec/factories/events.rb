FactoryBot.define do
  factory :event do
    title   { Faker::Book.title }
    content { Faker::Lorem.sentence }
    scheduled_date { Date.today + 7.day }
    start_time { 3.hours.ago }
    end_time { Time.now }
    participant_number { rand(1..20) }
    place { Gimei.city.kanji }
  end
end
