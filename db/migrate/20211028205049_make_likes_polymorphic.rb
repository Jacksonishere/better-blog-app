class MakeLikesPolymorphic < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :post_id, :likeable_id
    add_column :likes, :likeable_type, :string

    remove_index :likes, [:user_id, :likeable_id]
    add_index :likes, [:user_id, :likeable_id, :likeable_type], unique: true 
    #probably want to query for likes for each likeable thing, which is going to need to do a thing where it checks the thing is equal to the likeable_id and the type of the thing is equal to the likeable_type
    add_index :likes, [:likeable_id, :likeable_type]

  end
end
