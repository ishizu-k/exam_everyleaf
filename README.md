# README

README.mdファイルのデフォルトの記述を消去して、テーブルとスキーマをそれぞれ記載していきましょう。（モデル名・カラム名・データ型をそれぞれ書き込む）READMEは人に見せるための説明書としての役割を持っているので綺麗に見やすく書きましょう（READMEはマークダウンで書かれているので、マークダウン　記法などで検索して、綺麗に書くための記述方法を模索してみることをオススメします）

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
- content（string）
- limit（date）
- priority（string）
- status（string）

## Labelモデル
### labelsテーブル
- id（integer）
- task_id（integer）
- label_id（integer）

## Task_labelモデル
### task_labelsテーブル
- id（integer）
- label_name（string）
