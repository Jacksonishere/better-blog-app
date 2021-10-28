class AddParentToComments < ActiveRecord::Migration[6.1]
  def change
    #in english, this is add to comments table a parent_id, that is an int and nullable because the top comment cant be nested in a comment.
    #dont need add foreign_key because of ^ so we dont need referential integrity where you must add a parent_id when you create column.
    add_column :comments, :parent_id, :integer, null: true
  end
end
