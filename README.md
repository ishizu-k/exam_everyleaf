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

## Versions
- Ruby 2.6.3 
- Rails 5.2.3

## Table
### tasks table
|column|type|
|:--|--:|
|id|integer|
|user_id|integer|
|name|string|
|content|string|
|limit|date|
|priority|string|
|status|string|

### labelings table
|column|type|
|:--|--:|
|id|integer|
|task_id|string|
|label_id|string|

### labels table
|column|type|
|:--|--:|
|id|integer|
|name|string|

### users table
|column|type|
|:--|--:|
|id|integer|
|name|string|
|email|string|
|password_digest|string|
|admin|boolean|
