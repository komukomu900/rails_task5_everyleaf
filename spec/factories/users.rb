FactoryBot.define do
  factory :user1, class: User do
    name { "test1" }
    email { "test1@test.com" }
    password { "test" }
    admin { 'true' }
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
  factory :user5, class: User do
    name { "test5" }
    email { "test5@test.com" }
    password { "test" }
    admin { 'true' }
  end
  factory :user6, class: User do
    name { "test6" }
    email { "test6@test.com" }
    password { "test" }
    admin { 'true' }
  end
  factory :user7, class: User do
    name { "test7" }
    email { "test7@test.com" }
    password { "test" }
    admin { 'false' }
  end
  factory :user8, class: User do
    name { "test8" }
    email { "test8@test.com" }
    password { "test" }
    admin { 'false' }
  end
  factory :user9, class: User do
    name { "test9" }
    email { "test9@test.com" }
    password { "test" }
    admin { 'false' }
  end
  factory :user10, class: User do
    name { "test10" }
    email { "test10@test.com" }
    password { "test" }
    admin { 'false' }
  end
end
