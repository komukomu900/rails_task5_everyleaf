require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user7)
    FactoryBot.create(:first_task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    FactoryBot.create(:third_task, user: @user)
    @task = Task.create!(title: 'task', content: 'test', state: '未着手', deadline: '2021,01,02,21,30,00', user: @user)
    visit new_session_path
    fill_in 'session_email', with: 'test7@test.com'
    fill_in 'session_password', with: 'test'
    click_button 'ログイン'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title', with: 'task'
        fill_in 'task_content', with: 'task'
        select '未着手', from: 'task_state'
        select 'low', from: 'task_priority'
        fill_in 'task_deadline', with: '2021,01,02,21,30,00'
        click_on '作成'
        expect(page).to have_content 'task'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいること' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        t = Task.last
        task_list = all('.task_row')[1]
        expect(task_list).to have_content t.title
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