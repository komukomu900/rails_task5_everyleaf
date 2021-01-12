FactoryBot.define do
  factory :task do
    name { 'test1' }
    content { 'test_content' }
    state { '未着手' }
    deadline { '2021,01,14,16,40,00' }
  end
  factory :second_task, class: Task do
    name { 'test2' }
    content { 'test_content' }
    state { '未着手' }
    deadline { '2021,01,15,16,40,00' }
  end
  factory :third_task, class: Task do
    name { 'test3' }
    content { 'test_content' }
    state { '未着手' }
    deadline { '2021,01,16,16,40,00' }
  end
end