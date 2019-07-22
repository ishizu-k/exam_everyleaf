require 'rails_helper'

RSpec.feature "ユーザー管理機能", type: :feature do
  background do
    task1 = FactoryBot.create(:task)
    task2 = FactoryBot.create(:second_task)
  end

  scenario "ユーザー新規登録（同時にログイン）" do
    # ユーザー新規登録
    visit new_user_path
    fill_in 'ユーザー名', with: 'name'
    fill_in 'メールアドレス', with: 'name@example.com'
    fill_in 'パスワード', with: '000000'
    fill_in '確認用パスワード', with: '000000'
    click_button 'Create my account'
    # ログインしている
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
    visit tasks_path
    expect(page).to have_selector 'h3', text: 'Log in'
    visit new_task_path
    expect(page).to have_selector 'h3', text: 'Log in'
  end

  scenario "自分が作成したタスクだけが表示される" do
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
    # 自分が作成したタスクだけが表示される
    expect(page).to have_content 'test'
    expect(page).to have_content 'content'
    expect(page).to have_content '2029-07-07'
    expect(page).to have_content '未着手'
    expect(page).to have_content "高"
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
    expect(page).to have_content '2022-08-31'
    expect(page).to_not have_content 'Factoryで作ったデフォルトのタイトル２'
  end

  scenario "ログイン中、ユーザー登録画面に飛ぼうとするとマイページに遷移する" do
    # ログインする
    visit new_session_path
    fill_in 'メールアドレス', with: 'tanaka@example.com'
    fill_in 'パスワード', with: '111111'
    click_button 'Log in'
    # ユーザー登録画面に飛ぼうとするとマイページに遷移する
    visit new_user_path
    expect(page).to have_content 'tanaka'
    expect(page).to have_content 'tanaka@example.com'
  end

    scenario "自分以外のマイページは表示されない" do
      # ログインする
      visit new_session_path
      fill_in 'メールアドレス', with: 'tanaka@example.com'
      fill_in 'パスワード', with: '111111'
      click_button 'Log in'
      # save_and_open_page
      expect(page).to have_content 'tanaka'
      expect(page).to have_content 'tanaka@example.com'
      expect(page).to_not have_content 'yamada'
      expect(page).to_not have_content 'yamada@example.com'
    end

    scenario "ユーザー一覧が表示される" do
      # ログインする
      visit new_session_path
      fill_in 'メールアドレス', with: 'tanaka@example.com'
      fill_in 'パスワード', with: '111111'
      click_button 'Log in'
      # 管理画面
      visit admin_users_path
      expect(page).to have_content 'ユーザー一覧'
    end

    scenario "ユーザーの新規作成" do
      # ログインする
      visit new_session_path
      fill_in 'メールアドレス', with: 'tanaka@example.com'
      fill_in 'パスワード', with: '111111'
      click_button 'Log in'
      # 管理画面
      visit new_admin_user_path
      fill_in 'ユーザー名', with: 'name'
      fill_in 'メールアドレス', with: 'name@example.com'
      fill_in 'パスワード', with: '111111'
      fill_in '確認用パスワード', with: '111111'
      click_button 'Create'
      expect(page).to have_content 'name'
    end

    scenario "ユーザーの更新" do
      visit admin_users_path
      page.all("td")[3].click_link '編集'
      fill_in 'ユーザー名', with: 'sato'
      fill_in 'メールアドレス', with: 'sato@example.com'
      fill_in 'パスワード', with: '111111'
      fill_in '確認用パスワード', with: '111111'
      click_button 'Edit'
      expect(page).to have_content '編集しました'
      expect(page).to have_content 'sato'
    end

    scenario "ユーザーの削除" do
      visit admin_users_path
      page.all("td")[4].click_link '削除'
      expect(page).to have_content '削除しました'
    end

    scenario "ユーザーごとに作成したタスク一覧が表示される" do
      visit admin_users_path
      page.all("td")[2].click_link '詳細'
      expect(page).to have_content 'tanakaさんのタスク一覧'
      expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
    end
end

# テスト
# bin/rspec spec/features/user_spec.rb
# save_and_open_page
