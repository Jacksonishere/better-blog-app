class RemoveFkFromLikesToPost < ActiveRecord::Migration[6.1]
  def change
    #previously, when we first created the likes model, we created a foreign_key constraint likes that had a post_id FK. Even though we changed it to likeable_id, because this foreign key references a likeable object, not every likeable_id references a post. Some could reference a comment, and other likeable things. Thus the likeable id should have a fk constraint strictly with post. We need to remove it.
    remove_foreign_key :likes, :post
  end
end
