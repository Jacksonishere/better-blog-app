class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :post
  belongs_to :user
  #nesting comments relationship 

  #break convention
  #this comment has many comments in the Comment table that i can retreiving using the FK called parent_id. 
  has_many :comments, foreign_key: :parent_id
  #this comment's owner is in Comment class/model which you can find using the PK named parent_id
  belongs_to :parent, class_name: 'Comment', optional: true
end
