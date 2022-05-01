class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, length: { in: 1..250 }, presence: true, allow_blank: false
  validates_numericality_of :comments_counter, allow_nil: true, greater_than_or_equal_to: 0
  validates_numericality_of :likes_counter, allow_nil: true, greater_than_or_equal_to: 0
  after_save :update_post_counter

  def update_post_counter
    author.increment!(:post_counter)
  end

  def most_recent_comments
    comments.order(created_at: :desc).includes(:author).limit(5)
  end
end
