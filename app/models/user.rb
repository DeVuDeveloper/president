class User < ApplicationRecord
  before_create :add_role_to_user
  ROLES = %w[admin member].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  def add_role_to_user
    self.role = 'member'
  end

  validates :name, presence: true
  validates_numericality_of :post_counter, allow_nil: true, greater_than_or_equal_to: 0

  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def all_posts
    posts.order(created_at: :desc)
  end
end
