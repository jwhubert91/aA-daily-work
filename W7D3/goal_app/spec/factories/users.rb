require 'securerandom'

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    password { "hunter2" }
  end
end