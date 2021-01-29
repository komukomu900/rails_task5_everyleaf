require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  before do
    @user = FactoryBot.create(:user9)
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        user = @user
        task = user.tasks.build(title: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        user = @user
        task = user.tasks.build(title: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = @user
        task = user.tasks.build(title: '成功テスト', content: '成功テスト', state: '未着手', deadline: '2021,01,04,02,03,00')
        expect(task).to be_valid
      end
    end
  end
end