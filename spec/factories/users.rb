FactoryBot.define do
  factory :user1, class: User do
    name { "test1" }
    email { "test@test.com" }
    password { "test" }
    admin { 'false' }
  end
  factory :user2, class: User do
    name { "test2" }
    email { "test2@test.com" }
    password { "test" }
    admin { 'false' }
  end
  factory :user3, class: User do
    name { "test3" }
    email { "test3@test.com" }
    password { "test" }
    admin { 'false' }
  end
  factory :user4, class: User do
    name { "test4" }
    email { "test4@test.com" }
    password { "test" }
    admin { 'true' }
  end
end
