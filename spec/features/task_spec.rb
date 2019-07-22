# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @task1 = FactoryBot.create(:task, name: '付け加えた名前')
    @task2 = FactoryBot.create(:second_task, content: '付け加えたコンテント')
    # ログインする
    visit new_session_path
    fill_in 'メールアドレス', with: 'tanaka@example.com'
    fill_in 'パスワード', with: '111111'
    click_button 'Log in'
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content '付け加えた名前'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'タスク名', with: 'namenamename'
    fill_in 'タスク詳細', with: 'contentcontentcontent'
    fill_in '終了期限', with: '2019-07-07'
    select '未着手', from: 'ステータス'
    select "高", from: '優先順位'
    click_button '新規作成'
    expect(page).to have_content 'namenamename'
    expect(page).to have_content 'contentcontentcontent'
    expect(page).to have_content '2019-07-07'
    expect(page).to have_content '未着手'
    expect(page).to have_content 0
  end

  scenario "タスク詳細のテスト" do
    visit tasks_path
    page.all("td")[6].click_link '詳細'
    expect(page).to have_content '付け加えた名前'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    expect(Task.all.order(created_at: :desc)).to eq [@task2, @task1]
  end

  scenario "終了期限でソートするとタスクが終了期限の降順に並び替えられるかのテスト" do
    visit tasks_path
    expect(Task.all.order(created_at: :desc)).to eq [@task2, @task1]
    click_link '終了期限'
    expect(Task.all.order(limit: :desc)).to eq [@task1, @task2]
  end

  scenario "タスク名で検索できるかのテスト" do
    visit tasks_path
    fill_in 'task_name', with: '付け加えた名前'
    select 'ステータスから検索', from: 'task_status'
    click_button 'search'
    expect(page).to have_content '付け加えた名前'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
    expect(page).to have_content '2022-08-31'
    expect(page).to have_content '未着手'
    expect(page).to have_content 0
  end

  scenario "ステータスで検索できるかのテスト" do
    visit tasks_path
    fill_in 'task_name', with: ''
    select '未着手', from: 'task_status'
    click_button 'search'
    expect(page).to have_content '付け加えた名前'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'
    expect(page).to have_content '2022-08-31'
    expect(page).to have_content '未着手'
    expect(page).to have_content 0
  end

  scenario "優先順位でソートするとタスクが優先順位の高い順に並び替えられるかのテスト" do
    visit tasks_path
    expect(Task.all.order(created_at: :desc)).to eq [@task2, @task1]
    click_link '終了期限'
    expect(Task.all.order(priority: :asc)).to eq [@task1, @task2]
  end
end

# テスト
# bin/rspec spec/features/task_spec.rb
# save_and_open_page
