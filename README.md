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
