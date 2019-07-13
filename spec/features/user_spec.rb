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

  scenario "ログアウトする" do
    # ログインする
    visit new_session_path
    fill_in 'メールアドレス', with: 'tanaka@example.com'
    fill_in 'パスワード', with: '111111'
    click_button 'Log in'
    expect(page).to have_content 'tanaka'
    expect(page).to have_content 'tanaka@example.com'
    # ログアウトする
    click_link "Log Out"
    expect(page).to have_content 'ログアウトしました'
  end

  scenario "未ログイン状態でタスクのページに飛ぼうとするとログインページに遷移する" do
    # ログインする
    visit new_session_path
    fill_in 'メールアドレス', with: 'tanaka@example.com'
    fill_in 'パスワード', with: '111111'
    click_button 'Log in'
    expect(page).to have_content 'tanaka'
    expect(page).to have_content 'tanaka@example.com'
    # タスク作成
    visit new_task_path
    fill_in 'タスク名', with: 'test'
    fill_in 'タスク詳細', with: 'content'
    fill_in '終了期限', with: '2029-07-07'
    select '未着手', from: 'ステータス'
    select "高", from: '優先順位'
    click_button '新規作成'
    expect(page).to have_content 'test'
    expect(page).to have_content 'content'
    expect(page).to have_content '2029-07-07'
    expect(page).to have_content '未着手'
    expect(page).to have_content 0
    # ログアウトする
    click_link "Log Out"
    expect(page).to have_content 'ログアウトしました'
    # 未ログイン状態ではタスクページに行けない
    visit tasks_path
    expect(page).to have_selector 'h3', text: 'Log in'
    visit new_task_path
    expect(page).to have_selector 'h3', text: 'Log in'
    visit edit_task_path(1)
    expect(page).to have_selector 'h3', text: 'Log in'
    visit task_path(1)
    expect(page).to have_selector 'h3', text: 'Log in'
  end

end

# テスト
# bin/rspec spec/features/user_spec.rb
# save_and_open_page
