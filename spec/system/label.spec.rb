require 'rails_helper'
RSpec.describe 'タスク機能', type: :system do
  before do
    @user1 = FactoryBot.create(:user1)
    @task1 = FactoryBot.create(:first_task, user: @user1)
    @task2 = FactoryBot.create(:second_task, user: @user1)
    @task3 = FactoryBot.create(:third_task, user: @user1)
    @label1 = FactoryBot.create(:label1)
    @label2 = FactoryBot.create(:label2)
    @label3 = FactoryBot.create(:label3)
    FactoryBot.create(:labelling, task: @task1, label: @label1)
    FactoryBot.create(:labelling, task: @task2, label: @label2)
    FactoryBot.create(:labelling, task: @task3, label: @label3)
    visit new_session_path
    fill_in 'session_email', with: 'test1@test.com'
    fill_in 'session_password', with: 'test'
    click_button 'ログイン'
  end
  describe 'タスク一覧機能' do
    context 'ログイン後の確認' do
      it 'ログイン後マイページからタスク一覧画面の検証' do
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test1@test.com'
      end
      it 'タスク一覧画面の確認' do
        visit root_path
        @tasks = Task.all
        t0 = @tasks[0]
        t1 = @tasks[1]
        t2 = @tasks[2]
        task_list0 = all('.task_row')[1]
        task_list1 = all('.task_row')[2]
        task_list2 = all('.task_row')[3]
        expect(task_list0).to have_content t2.title
        expect(task_list1).to have_content t1.title
        expect(task_list2).to have_content t0.title
      end
    end
    context '検索条件検証(ラベル名を含む)' do
      it '検索(タスク名/ステータス/ラベル名)' do
        visit root_path
        fill_in 'title', with: 'test2'
        select '着手', from: 'state'
        select 'ラベル2', from: 'label_id'
        click_on '検索'
        task = all('.task_row')
        expect(task[1]).to have_content 'test_content'
        expect(task[1]).to have_content 'ラベル2'
      end
      it '検索(タスク名/ラベル名)' do
        visit root_path
        fill_in 'title', with: 'test2'
        select 'ラベル2', from: 'label_id'
        click_on '検索'
        task = all('.task_row')
        expect(task[1]).to have_content 'test_content'
        expect(task[1]).to have_content 'ラベル2'
      end
      it '検索(ステータス/ラベル名)' do
        visit root_path
        select '未着手', from: 'state'
        select 'ラベル1', from: 'label_id'
        click_on '検索'
        task = all('.task_row')
        expect(task[1]).to have_content 'test_content'
        expect(task[1]).to have_content 'ラベル1'
      end
      it '検索(ラベル名)' do
        visit root_path
        select 'ラベル3', from: 'label_id'
        click_on '検索'
        task = all('.task_row')
        expect(task[1]).to have_content 'test_content'
        expect(task[1]).to have_content 'ラベル3'
      end
    end
    describe 'タスク作成機能' do
      before do
        visit root_path
      end
      context 'タスク新規作成' do
        it 'ラベル追加したタスク作成1' do
          click_link 'タスク作成'
          expect(page).to have_content 'タスク作成'
          fill_in 'task_title', with: 'task1_title'
          fill_in 'task_content', with: 'task1_content'
          fill_in 'task_deadline', with: '002021,01,16,16,40,00'
          select '着手', from: 'task_state'
          select 'low', from: 'task_priority'
          check 'ラベル3'
          click_on '作成'
          expect(page).to have_content 'task1_title'
          expect(page).to have_content 'task1_content'
          expect(page).to have_content 'ラベル3'
        end
        it 'ラベル追加したタスク作成2' do
          click_link 'タスク作成'
          expect(page).to have_content 'タスク作成'
          fill_in 'task_title', with: 'task2_title'
          fill_in 'task_content', with: 'task2_content'
          fill_in 'task_deadline', with: '002021,01,26,16,40,00'
          check 'ラベル2'
          click_on '作成'
          expect(page).to have_content 'task2_title'
          expect(page).to have_content 'task2_content'
          expect(page).to have_content 'ラベル2'
        end
        it 'ラベル追加したタスク作成3' do
          click_link 'タスク作成'
          expect(page).to have_content 'タスク作成'
          fill_in 'task_title', with: 'task3_title'
          fill_in 'task_content', with: 'task3_content'
          fill_in 'task_deadline', with: '002021,11,26,16,40,00'
          select 'low', from: 'task_priority'
          check 'ラベル1'
          click_on '作成'
          expect(page).to have_content 'task3_title'
          expect(page).to have_content 'task3_content'
          expect(page).to have_content 'ラベル1'
        end
        it 'ラベル追加したタスク作成4' do
          click_link 'タスク作成'
          expect(page).to have_content 'タスク作成'
          fill_in 'task_title', with: 'task4_title'
          fill_in 'task_content', with: 'task4_content'
          fill_in 'task_deadline', with: '002021,01,06,16,40,00'
          select '完了', from: 'task_state'
          check 'ラベル3'
          click_on '作成'
          expect(page).to have_content 'task4_title'
          expect(page).to have_content 'task4_content'
          expect(page).to have_content 'ラベル3'
        end
        it 'ラベルなしタスク作成' do
          click_link 'タスク作成'
          expect(page).to have_content 'タスク作成'
          fill_in 'task_title', with: 'task_title'
          fill_in 'task_content', with: 'task_content'
          fill_in 'task_deadline', with: '002021,02,26,16,40,00'
          click_on '作成'
          expect(page).to have_content 'task_title'
          expect(page).to have_content 'task_content'
        end
      end
    context 'タスク編集時' do
        it 'ラベル追加' do
          visit root_path
          task = Task.find_by(title: 'test3')
          expect(page).to have_link '編集'
          click_link '編集', href: edit_task_path(task)
          expect(page).to have_content 'test3'
          check 'ラベル1'
          click_button '編集'
          click_on 'タスク一覧'
          task = Task.find_by(title: 'test3')
          expect(page).to have_link '詳細', href: task_path(task)
          click_link '詳細', href: task_path(task)
          expect(page).to have_content 'test3'
          expect(page).to have_content 'test_content'
          expect(page).to have_content 'ラベル1'
          expect(page).to have_content 'ラベル3'
        end
      end
    end
  end
end