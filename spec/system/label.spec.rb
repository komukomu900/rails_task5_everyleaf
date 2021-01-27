require 'rails_helper'
describe 'タスク機能', type: :system do
  before do
    @user1 = FactoryBot.create(:user1)
    @task1 = FactoryBot.create(:task)
    @task1 = FactoryBot.create(:second_task)
    @task1 = FactoryBot.create(:third_task)
    @label1 = FactoryBot.create(:label1)
    @label2 = FactoryBot.create(:label2)
    @label3 = FactoryBot.create(:label3)
  end