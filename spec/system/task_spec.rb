require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    @task = Task.create!(name: 'task', content: 'test', state: '1', deadline: '2021,01,02,21,30,00')
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: 'task'
        fill_in 'task_content', with: 'task'
        select '未着手', from: 'task_state'
        fill_in 'task_deadline', with: '2021,01,02,21,30,00'
        click_on '作成'
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task', content: 'test', state: '着手', deadline: '2021,01,02,21,30,00')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(@task)
        expect(page).to have_content 'task'
       end
     end
  end
end 