# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Essay.destroy_all
EssayContributor.destroy_all

30.times do
    User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: rand(1..100).to_f, profession: Faker::Job.title, bio: Faker::Lorem.sentence(rand(2..10)).chomp('.'))
    Essay.create(title: Faker::Book.title, content: Faker::Quotes::Shakespeare.hamlet_quote, essay_type: Faker::Book.genre)
end

50.times do
    EssayContributor.create(user_id: User.all.sample.id, essay_id: Essay.all.sample.id)
end
