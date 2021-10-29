class Post < ApplicationRecord
    belongs_to :user
    has_many :comments

    #this says it has many likes as a likeable thing. Rails knows a like belongs to a likeable thing aka this post. 
    #probably goes to the likes and checks the FK likeable_id that matches Post in the likeable_type field.
    #this is like foreign_key: :likeable but instead rails creates the association that sets the likeable type to this model in the likes table,
    has_many :likes, as: :likeable
end
