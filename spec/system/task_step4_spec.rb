require 'rails_helper'
describe 'ユーザ管理機能', type: :system do
  before do
    @user1 = FactoryBot.create(:user1)
    FactoryBot.create(:user2)
    FactoryBot.create(:user3)
    FactoryBot.create(:user4)
  end
  describe 'ユーザー登録のテスト' do
    context 'ユーザーを新規作成した場合' do
      it '作成後マイページが表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'yuyu'
        fill_in 'user_email', with: 'user@yuyu.com'
        fill_in 'user_password', with: 'hogegege'
        fill_in 'user_password_confirmation', with: 'hogegege'
        click_button '作成'
        expect(page).to have_content 'yuyu'
        expect(page).to have_content 'user@yuyu.com'
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ログイン時の操作検証' do
      it 'ログインせずにタスク一覧に入ろうとした場合ログイン画面が表示される' do
        visit new_session_path
        expect(page).to have_button 'ログイン'
      end
      it 'ログインができる' do
        visit new_session_path
        fill_in 'session_email', with: 'test4@test.com'
        fill_in 'session_password', with: 'test'
        click_button 'ログイン'
        expect(page).to have_content 'test4'
        expect(page).to have_content 'test4@test.com'
      end
    end
    context 'ログイン後の操作検証' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'test4@test.com'
        fill_in 'session_password', with: 'test'
        click_button 'ログイン'
      end
      it 'ログイン後マイページが表示される' do
        expect(page).to have_content 'test4'
        expect(page).to have_content 'test4@test.com'
        expect(page).to have_link 'ユーザ編集'
      end
      it '他人の詳細画面にアクセスすると参照できずタスク一覧が表示される' do
        visit user_path(@user1)
        expect(page).to have_content 'この操作はできません'
      end
      it 'ログアウトができる' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '機能' do
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