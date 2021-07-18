FactoryBot.define do
  factory :user_tag_map do
    association :user
    association :tag
  end
end
