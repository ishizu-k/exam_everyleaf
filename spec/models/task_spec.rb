require 'rails_helper'

RSpec.describe Task, type: :model do
  it "nameが空ならバリデーションが通らない" do
    task = Task.new(name: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end

  it "nameとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.new(name: '成功テスト', content: '成功テスト')
    expect(task).to be_valid
  end

  it "nameが文字数31以上ならバリデーションが通らない" do
    task = Task.new(name: 'a'*31, content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "contentが文字数501以上ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: 'a'*501)
    expect(task).not_to be_valid
  end

  it "nameの文字数30以下かつcontentの文字数500以下ならバリデーションが通る" do
    task = Task.new(name: 'a'*30, content: 'a'*500)
    expect(task).to be_valid
  end
end
