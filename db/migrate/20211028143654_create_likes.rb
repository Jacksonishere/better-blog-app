class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    #adding a constraint on the DB level where the combination of user_id and post_id, FKs, are unique because we don't want to add a separate record for everytime a user relikes after unliking
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
