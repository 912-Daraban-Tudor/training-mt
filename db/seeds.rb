# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



UserRole.delete_all
Permission.delete_all
AppAction.delete_all
Role.delete_all
Story.unscoped.delete_all

# TREBUIE adăugat asta ca să rupi legăturile înainte să ștergi coloanele/boardurile!
BoardColumn.delete_all

Column.unscoped.delete_all
Board.unscoped.delete_all
User.unscoped.delete_all

user1 = User.create!(
  name: "bob",
  email: "bob@bob.com",
  password: "password123",
  password_confirmation: "password123"
)

user2 = User.create!(
  name: "bobbert",
  email: "bobbert@bob.com",
  password: "password123",
  password_confirmation: "password123"
)
board1 = Board.create!(name: "project1", user: user1)
board2 = Board.create!(name: "proj2", user: user2)

icebox  = Column.create!(name: "icebox", status: "icebox")
backlog = Column.create!(name: "backlog",  status: "backlog")
current = Column.create!(name: "current", status: "current")
done    = Column.create!(name: "delivered", status: "delivered")

board1.columns << [icebox, backlog, current, done]
board2.columns << [icebox, backlog, current, done]

Story.create!(title: "week1", status: "backlog", board: board1)
Story.create!(title: "week2", status: "icebox", board: board1)
Story.create!(title: "test", status: "finished", board: board1)
Story.create!(title: "testtest", status: "pending", board: board1)


AppAction.create!(name: "view_board")
AppAction.create!(name: "edit_board")
AppAction.create!(name: "edit_story")


admin = Role.create!(name: "Admin")
Role.create!(name: "Editor")
Role.create!(name: "Viewer")

User.first.roles << admin