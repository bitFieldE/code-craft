FactoryBot.define do
  factory :post do
    title   { Faker::Book.title }
    rate    { rand(0.5...5.0) }
    content { Faker::Lorem.sentence }
  end
end
