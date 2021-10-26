class AddUserToPost < ActiveRecord::Migration[6.1]
  #set up the relationship between user and posts. each post belongs to a user and a user can have many posts. 
  #putting foreign_key true enforces referential integrity, so a post must have a user_id that points to a user in users table.
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
