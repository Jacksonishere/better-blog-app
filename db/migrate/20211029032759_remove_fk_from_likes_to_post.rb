class RemoveFkFromLikesToPost < ActiveRecord::Migration[6.1]
  def change
    #previously, when we first created the likes model, we created a foreign_key constraint likes that had a post_id FK. Even though we changed it to likeable_id, 
    remove_foreign_key :likes, :posts
  end
end
