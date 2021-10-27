class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :post
  belongs_to :user
  #nesting comments relationship 

  #convention
  #knows to go to the comments table and look for a FK called comment_id.
  has_many :comments, foreign_key: :parent_id

  #knows to go to the class/model called parent but since there is none, we need to specify we're going back to comment. 
  #default config for belongs_to requires you to have the association, aka parent_id not null to save in database unless you put optional: true
  belongs_to :parent, class_name: 'Comment', optional: true
end
