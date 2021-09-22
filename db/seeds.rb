# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

N = 11
M = 5
K = 100

(1..N).each do |number|
  number_s = number.to_s
  user = User.new(name: 'user_' + number_s, email: number_s + '@abc.com', password: 'password')
  user.save
end
  
(1..N*M).each do |num|
  user = User.find(rand(1..N))
  # teamを作成
  num_s = num.to_s
  team = user.teams.build(name: 'team-' + user.name + '_' + num_s, description: 'ここにちーむの説明が入ります。' + num_s)
  team.save
  team.add_member(user)
end

(1..K).each do |_|
  team = Team.find(rand(1..N*M))
  team.add_member(User.find(rand(1..N)))
end