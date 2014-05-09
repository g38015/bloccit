# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

# Create Posts
50.times do
  Post.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end
posts = Post.all

# Create Comments
100.times do 
  Comment.create(
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

User.first.update_attributes(
  email: 'phitchcock@me.com',
  password: 'helloworld',
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"