require 'rails_helper'

RSpec.feature "ユーザー管理機能", type: :feature do
  background do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:second_user)
  end

  scenario "ユーザー新規登録" do
    visit new_user_path
    fill_in 'ユーザー名', with: 'name'
    fill_in 'メールアドレス', with: 'name@example.com'
    fill_in 'パスワード', with: '000000'
    fill_in '確認用パスワード', with: '000000'
    click_button 'Create my account'
    expect(page).to have_content 'name'
    expect(page).to have_content 'name@example.com'
  end

  scenario "ログインする" do
    visit new_session_path
    fill_in 'メールアドレス', with: 'tanaka@example.com'
    fill_in 'パスワード', with: '111111'
    click_button 'Log in'
    expect(page).to have_content 'tanaka'
    expect(page).to have_content 'tanaka@example.com'
  end
end

#テスト
#bin/rspec spec/features/user_spec.rb
