# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

N = 11
M = 50
K = 100
L = 1000 

# ユーザーを作成
(1..N).each do |number|
  number_s = number.to_s
  user = User.new(name: 'user_' + number_s, email: number_s + '@abc.com', password: 'password')
  user.save
end
print("Generated #{N} users.\n")
 
# チームを適当に作成
(1..M).each do |num|
  user = User.find(rand(1..N))
  # teamを作成
  num_s = num.to_s
  team = user.teams.build(name: 'team-' + user.name + '_' + num_s, description: 'ここにちーむの説明が入ります。' + num_s)
  team.save
  team.add_member(user)
end
print("Generated #{M} teams.\n")

# チームにメンバーを適当に追加
(1..K).each do |_|
  team = Team.find(rand(1..M))
  team.add_member(User.find(rand(1..N)))
end
print("Randomly add #{K} users to the group.\n")

status_list = ['Not Started', 'In Progress', 'Done', 'Pendding']
# タスクを適当に追加
(1..L).each do |num|
  user = User.find(rand(1..N))
  id = rand(2) == 1 ? nil : Team.find(rand(1..M)).id

  task = user.tasks.build(
    title: 'sample task #' + num.to_s,
    content: 'sample content',
    deadline: Time.current.since(rand(1..500).days),
    status: status_list[rand(0..3)],
    team_id: id
  )
  task.save
end
print("Generated #{L} tasks.\n")
  
print("Done.\n")