require 'rails_helper'
describe 'ユーザ管理機能', type: :system do
  describe '機能' do
    before do
      FactoryBot.create(:user1)
      FactoryBot.create(:user2)
      FactoryBot.create(:user3)
      FactoryBot.create(:user4)
    end
    context '管理ユーザーでの操作' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'test4@test.com'
        fill_in 'session_password', with: 'test'
        click_button 'ログイン'
      end
      it 'ユーザーの新規登録ができる' do
        click_link 'ユーザ管理画面'
        click_link 'ユーザ作成'
        fill_in 'user_name', with: 'ttttt'
        fill_in 'user_email', with: 'tttt@test.com'
        fill_in 'user_password', with: 'test'
        fill_in 'user_password_confirmation', with: 'test'
        click_button '作成'
        expect(page).to have_content 'ユーザ一覧'
        expect(page).to have_content 'ttttt'
        expect(page).to have_content 'tttt@test.com'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        click_link 'ユーザ管理画面'
        user = User.find_by(name: 'test1')
        expect(page).to have_link '詳細', href: admin_user_path(user)
        click_link '詳細', href: admin_user_path(user)
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test@test.com'
        expect(page).to have_link 'ユーザ編集'
      end
      it 'ユーザーの編集画面から編集できる' do
        click_link 'ユーザ管理画面'
        user = User.find_by(name: 'test2')
        click_link '編集', href: edit_admin_user_path(user)
        fill_in 'user_name', with: 'test2'
        fill_in 'user_email', with: 'test22@test.com'
        click_button '編集'
        sleep(8)
        expect(page).to have_content 'test2'
        expect(page).to have_content 'test22@test.com'
      end
      it 'ユーザーの一覧画面から削除できる' do
        click_link 'ユーザ管理画面'
        user = User.find_by(name: 'test3')
        expect(page).to have_link '削除', href: admin_user_path(user)
        click_link '削除', href: admin_user_path(user)
        expect(page).to have_content '削除しました'
        expect(page).not_to have_content 'test3'
        expect(page).not_to have_content 'test3@test.com'
      end
    end
  end
end