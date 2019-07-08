FactoryBot.define do
  factory :task do
    name { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    limit { '2022-08-31'}
    status { '未着手' }
    priority { 0 }
  end

  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    limit { '2019-08-31'}
    status { '着手' }
    priority { 1 }
  end
end
