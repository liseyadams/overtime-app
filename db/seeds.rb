User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Jon", last_name: "Snow")
puts "1 user created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: 1)
end
puts "100 Post have been created"