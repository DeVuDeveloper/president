class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true

  after_create :update_likes_counter

  def update_likes_counter
    post.update(likes_counter: post.likes.size)
  end
end
