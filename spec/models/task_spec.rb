require 'rails_helper'

RSpec.describe Task, type: :model do
  it "nameが空ならバリデーションが通らない" do
    task = Task.new(name: '', content: '失敗テスト', limit: Date.today+1, status: '未着手')
    # task = FactoryBot.create(:task, name: '')
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: '', limit: Date.today+1, status: '未着手')
    expect(task).not_to be_valid
  end

  it "nameとcontentに内容が記載されていればバリデーションが通る" do
    task = FactoryBot.create(:task, name: '成功テスト')
    expect(task).to be_valid
  end

  it "nameが文字数31以上ならバリデーションが通らない" do
    task = Task.new(name: 'a'*31, content: '失敗テスト', limit: Date.today+1, status: '未着手')
    expect(task).not_to be_valid
  end

  it "contentが文字数501以上ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: 'a'*501, limit: Date.today+1, status: '未着手')
    expect(task).not_to be_valid
  end

  it "nameの文字数30以下かつcontentの文字数500以下ならバリデーションが通る" do
    task = FactoryBot.create(:task, name: 'a'*30, content: 'a'*500)
    # task = Task.new(name: 'a'*30, content: 'a'*500, limit: Date.today+1, status: '未着手')
    expect(task).to be_valid
  end

  it "task_indexスコープを使用し、作成日時降順のタスク一覧を表示できる" do
    expect(Task.all.task_index).to eq Task.all.order(created_at: :desc)
  end

  it "sort_expiredスコープを使用し、終了期限降順にソートできる" do
    expect(Task.all.sort_expired).to eq Task.all.order(limit: :desc)
  end

  it "search_task_nameスコープを使用し、タスク名で検索できる" do
    task = FactoryBot.create(:task)
    # task1 = Task.new(name: 'test', content: 'hogehoge', limit: Date.today+1, status: '着手')
    # task1.save
    expect(Task.search_task_name(task[:name])).to include task
    # task2 = Task.new(name: 'test2', content: 'hogehoge', limit: Date.today+1, status: '着手')
    # task2.save
    # expect(Task.search_task_name(task2[:name])).to include task2
  end

  it "search_statusスコープを使用し、ステータスで検索できる" do
    task = FactoryBot.create(:task)
    # task1 = Task.new(name: 'test', content: 'hogehoge', limit: Date.today+1, status: '未着手')
    # task1.save
    # expect(Task.search_status(task1[:status])).to include task1
    # task2 = Task.new(name: 'test2', content: 'hogehoge', limit: Date.today+1, status: '着手')
    # task2.save
    expect(Task.search_status(task[:status])).to include task
  end

  it "sort_prioritizedスコープを使用し、優先順位が高い順にソートできる" do
    expect(Task.all.sort_prioritized).to eq Task.all.order(priority: :asc)
  end
end

# テスト
# bin/rspec
