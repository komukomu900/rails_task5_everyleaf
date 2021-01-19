require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, name: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, name: "sample") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.get_by_name('task')).to include(task)
        expect(Task.get_by_name('task')).not_to include(second_task)
        expect(Task.get_by_name('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.get_by_state('未着手')).to include(task)
        expect(Task.get_by_state('未着手')).not_to include(second_task)
        expect(Task.get_by_state('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        expect(Task.search(name:'task', state:'未着手')).to include(task)
      end
    end
  end
end