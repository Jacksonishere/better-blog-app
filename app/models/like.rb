class Like < ApplicationRecord
  #in the model layer, make sure the combination of user_id and post_id is unique
  #use user_id and post_id so we dont have to run more queries that we'd have to do if we just put user, post
  validates :user_id, uniqueness: {scope: :post_id }

  #there is pk named user_id and post_id that references user table and post table.
  belongs_to :user
  belongs_to :post
end
