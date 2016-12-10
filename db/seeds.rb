User.create!(name:  "Brant",
             email: "brantwellman@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)

User.create!(name:  "Example User",
             email: "example@email.com",
             password:              "password",
             password_confirmation: "password")

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@email.com"
  password = "password"
  user = User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
  p user
end
