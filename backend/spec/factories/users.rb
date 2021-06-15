FactoryBot.define do
  factory :user do
    name                  { Faker::Lorem.characters(number: 10) }
    email                 { Faker::Internet.email }
    description           { Faker::Lorem.sentence(word_count: 50) }
    password              { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
  end
end
