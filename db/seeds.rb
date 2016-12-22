p User.create!(name:  "Brant User",
             email: "brantwellman@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

p User.create!(name:  "Example User",
             email: "example@email.com",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)

p User.create!(name:  "Dan User",
            email: "dan@email.com",
            password:              "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now)

p User.create!(name:  "Other User",
             email: "other@email.com",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)

p User.create!(name:  "Loser User",
            email: "loser@email.com",
            password:              "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now)

p User.create!(name:  "Winner User",
             email: "winner@email.com",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@email.com"
  password = "password"
  user = User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  p user
end

users = User.order(:created_at).take(6)
50.times do |n|
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
