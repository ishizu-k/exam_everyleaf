# README

## Deployment
- 前提：gitインストール済み、Herokuアカウント登録済み
- Heroku Toolbeltをインストール
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
- herokuにログイン
heroku login
- アセットプリコンパイル
rails assets:precompile RAILS_ENV=production
- gitリポジトリ作成
git init
git add -A
git commit -m "コミットメッセージ"
- herokuアプリケーション作成
heroku create アプリ名
- デプロイ
git push heroku master
- マイグレーション
heroku run rails db:migrate

## System Versions
- Ruby version  2.6.3 
- Rails version  5.2.3

## Userモデル
### usersテーブル
- id（integer）
- name（string）
- email（string）
- password_digest（string）

## Taskモデル
### tasksテーブル
- id（integer）
- user_id（integer）
- name(string)
- content（string）
- limit（date）
- priority（string）
- status（string）

## Task_labelモデル
### task_labelsテーブル
- id（integer）
- task_id（integer）
- label_id（integer）

## Labelモデル
### labelsテーブル
- id（integer）
- name（string）
