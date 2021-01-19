require 'rails_helper'
describe 'タスク管理機能', type: :system do
  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'name', with: 'test3'
        # 検索ボタンを押す
        click_on '検索'
        expect(page).to have_content 'test3'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit tasks_path
        select '完了', from: 'state'
        click_on '検索'
        expect(page).to have_content 'test3'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        visit tasks_path
        fill_in 'name', with: 'test3'
        select '完了', from: 'state'
        click_on '検索'
        expect(page).to have_content 'test3'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "優先順位でソートする" do
        visit tasks_path
        click_on '優先順位でソートする'
        @tasks = Task.all
        t0 = @tasks[0]
        t1 = @tasks[1]
        t2 = @tasks[2]
        task_list0 = all('.task_row')[0]
        task_list1 = all('.task_row')[1]
        task_list2 = all('.task_row')[2]
        expect(task_list0).to have_content t2.name
        expect(task_list1).to have_content t1.name
        expect(task_list2).to have_content t0.name
      end
    end
  end
end