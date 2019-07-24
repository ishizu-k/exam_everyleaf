# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |i|
  user = User.new(
    name: "adminユーザー#{i}",
    email: "test#{i}@example.com",
    password: "111111",
    password_confirmation: "111111",
    admin: "true"
  )
  10.times do |t|
  user.tasks.build(
    name: "#{t}番目のタスク",
    content: "#{t}番目のタスクの内容",
    limit: "2019-07-28",
    status: "着手",
    priority: "中",
    user_id: "#{i}"
  )
  end
  user.save
end

10.times do |u|
  user = User.new(
    name: "not_adminユーザー#{u}",
    email: "test2#{u}@example.com",
    password: "111111",
    password_confirmation: "111111",
    admin: "false"
  )
  10.times do |t|
  user.tasks.build(
    name: "#{t}番目のタスク",
    content: "#{t}番目のタスクの内容",
    limit: "2019-07-28",
    status: "着手",
    priority: "中",
    user_id: "#{u}"
  )
  end
  user.save
end

10.times do |l|
  label = Label.new(name: "ラベル#{l}")
  label.labelings.build(label_id: "#{l}", task_id: "#{l}")
  label.save
end

# User.create!(
#   name: "test1",
#   email: "test@example.com",
#   password: "111111",
#   password_confirmation: "111111",
#   admin: "true"
# )
#
# Task.create!(
#   name: "1番目のタスク",
#   content: "1番目のタスクの内容",
#   limit: "2019-07-28",
#   status: "着手",
#   priority: "中",
#   user_id: 1
# )
#
# Labeling.create!(
#   task_id: 1,
#   label_id: 1
# )
#
# Label.create!(
#   name: "ラベル1"
# )
