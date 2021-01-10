FactoryBot.define do
  factory :task do
    name { 'test_title' }
    content { 'test_content' }
    state { '未着手' }
    deadline { '2021,01,14,16,40,00' }
  end
end