FactoryBot.define do
  factory :user do
    name { "tanaka" }
    email { "tanaka@example.com" }
    password { "111111" }
    password_digest { "111111" }
  end

  factory :second_user, class: User do
    name { "yamada" }
    email { "yamada@example.com" }
    password { "222222" }
    password_digest { "222222" }
  end
end
