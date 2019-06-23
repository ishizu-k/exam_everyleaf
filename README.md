# README


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
