=begin
FactoryGirl.define do
  factory :user do
    name     "Shinji Kamei"
    email    "example@railstutorial.com"
    password "kameshin"
    password_confirmation "kameshin"
  end
end
=end


FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end
end

