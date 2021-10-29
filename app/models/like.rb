class Like < ApplicationRecord
  #in the model layer, make sure the combination of user_id and post_id is unique
  #use user_id and post_id so we dont have to run more queries that we'd have to do if we just put user, post
  validates :user_id, uniqueness: {scope: [:likeable_id, :likeable_type] }

  #there is pk named user_id and post_id that references user table and post table.
  belongs_to :user
  #instead of belonging to just a post, it belongs to a likeable thing whether it be a post, image, comment. Rails expects a FK called likeable_id which points back to the likeable thing. Likeable_type is the model, or className, which we go to grab the likeable things and rails knows to set it when you create a like for the likeable thing. 
  belongs_to :likeable, polymorphic: true
end
