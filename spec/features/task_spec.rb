# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    # タスク作成
    @task1 = FactoryBot.create(:task, name: '付け加えた名前')
    @task2 = FactoryBot.create(:second_task, content: '付け加えたコンテント')
    # ラベル作成
    @label1 = FactoryBot.create(:label)
    @label2 = FactoryBot.create(:label, name: "ラベル2")
    @label3 = FactoryBot.create(:label, name: "ラベル3")
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

  scenario "タスクに複数のラベルをつけられる" do
    visit new_task_path
    fill_in 'タスク名', with: 'name'
    fill_in 'タスク詳細', with: 'content'
    fill_in '終了期限', with: '2019-08-08'
    select '未着手', from: 'ステータス'
    select "高", from: '優先順位'
    check 'task_label_ids_25'
    check 'task_label_ids_27'
    click_button '新規作成'
    expect(page).to have_content 'name'
    expect(page).to have_content 'content'
    expect(page).to have_content '2019-08-08'
    expect(page).to have_content '未着手'
    expect(page).to have_content 0
    expect(page).to have_content 'ラベル1'
    expect(page).to have_content 'ラベル3'
  end

  scenario "タスク詳細画面で紐づいているラベル一覧を表示" do
    visit new_task_path
    fill_in 'タスク名', with: 'name'
    fill_in 'タスク詳細', with: 'content'
    fill_in '終了期限', with: '2019-08-23'
    select '未着手', from: 'ステータス'
    select "高", from: '優先順位'
    check 'task_label_ids_29'
    check 'task_label_ids_30'
    click_button '新規作成'
    visit tasks_path
    page.all("td")[6].click_link '詳細'
    expect(page).to have_content 'ラベル2'
    expect(page).to have_content 'ラベル3'
  end

  scenario "ラベルからタスクを検索する" do
    # タスク作成
    visit new_task_path
    fill_in 'タスク名', with: 'sample1'
    fill_in 'タスク詳細', with: 'content'
    fill_in '終了期限', with: '2019-07-25'
    select '着手', from: 'ステータス'
    select "高", from: '優先順位'
    check 'task_label_ids_31'
    click_button '新規作成'
    visit new_task_path
    fill_in 'タスク名', with: 'sample2'
    fill_in 'タスク詳細', with: 'content'
    fill_in '終了期限', with: '2019-08-25'
    select '未着手', from: 'ステータス'
    select "低", from: '優先順位'
    check 'task_label_ids_32'
    check 'task_label_ids_33'
    click_button '新規作成'
    # 検索
    visit tasks_path
    select 'ラベル1', from: 'task_label_id'
    click_button 'search'
    expect(page).to have_content 'sample1'
    expect(page).to_not have_content 'sample2'
  end
end

# テスト
# bin/rspec spec/features/task_spec.rb
# save_and_open_page
