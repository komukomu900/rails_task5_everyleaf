require 'rails_helper'
describe '検索機能', type: :model do
  before do
    @user = FactoryBot.create(:user5)
    @task1 = FactoryBot.create(:first_task, title: 'task', user: @user)
    @task2 = FactoryBot.create(:second_task, title: "sample", user: @user)
  end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.get_by_title('task')).to include(@task1)
        expect(Task.get_by_title('task')).not_to include(@task2)
        expect(Task.get_by_title('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.get_by_state('未着手')).to include(@task1)
        expect(Task.get_by_state('未着手')).not_to include(@task2)
        expect(Task.get_by_state('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect(Task.search(title:'task', state:'未着手')).to include(@task1)
      end
    end
end