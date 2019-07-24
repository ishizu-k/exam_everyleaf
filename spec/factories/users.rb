FactoryBot.define do
  factory :user do
    name { "tanaka" }
    email { "tanaka@example.com" }
    password {"111111"}
    password_confirmation { "111111" }
    admin {"true"}
  end

  factory :second_user, class: User do
    name { "yamada" }
    email { "yamada@example.com" }
    password { "222222" }
    password_confirmation { "222222" }
    admin {"false"}
  end
end
