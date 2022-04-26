class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
end

def update_post_counter
  author.increment!(post_counter)
end

def most_recent_comments
  comments.limit(5).order(created_at: desc)
end
