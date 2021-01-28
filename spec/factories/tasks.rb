FactoryBot.define do
  factory :first_task, class: Task do
    title { 'test1' }
    content { 'test_content' }
    state { '未着手' }
    priority { 'low' }
    deadline { '2021,01,14,16,40,00' }
    association :user
  end
  factory :second_task, class: Task do
    title { 'test2' }
    content { 'test_content' }
    state { '着手' }
    priority { 'midium' }
    deadline { '2021,01,15,16,40,00' }
    association :user
  end
  factory :third_task, class: Task do
    title { 'test3' }
    content { 'test_content' }
    state { '完了' }
    priority { 'high' }
    deadline { '2021,01,16,16,40,00' }
    association :user
  end
end