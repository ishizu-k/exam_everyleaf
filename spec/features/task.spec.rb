# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    # backgroundの中に記載された記述は、そのカテゴリ内（feature "タスク管理機能", type: :feature do から endまでの内部）
    # に存在する全ての処理内（scenario内）で実行される
    # （「タスク一覧のテスト」でも「タスクが作成日時の降順に並んでいるかのテスト」でも、background内のコードが実行される）
    @task1 = FactoryBot.create(:task, name: '付け加えた名前')
    @task2 = FactoryBot.create(:second_task, content: '付け加えたコンテント')
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content '付け加えた名前'
    expect(page).to have_content '付け加えたコンテント'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
    # タスクのタイトルと内容をそれぞれfill_in（入力）する
    fill_in 'タスク名', with: 'namenamename'
    fill_in 'タスク詳細', with: 'contentcontentcontent'
    fill_in '終了期限', with: '2019-07-07'
    click_button '新規作成'
    # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
    # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
    expect(page).to have_content 'namenamename'
    expect(page).to have_content 'contentcontentcontent'
    expect(page).to have_content '2019-07-07'
  end

  scenario "タスク詳細のテスト" do
    visit tasks_path
    #save_and_open_page
    page.all("td")[3].click_link '詳細'
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
    expect(page).to have_content '付け加えたコンテント'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    expect(Task.all.order(created_at: :desc)).to eq [@task2, @task1]
  end

  scenario "終了期限でソートするとタスクが終了期限の降順に並び替えられるかのテスト" do
    visit tasks_path
    expect(Task.all.order(created_at: :desc)).to eq [@task2, @task1]
    click_link '終了期限でソートする'
    expect(Task.all.order(limit: :desc)).to eq [@task1, @task2]
  end
end
