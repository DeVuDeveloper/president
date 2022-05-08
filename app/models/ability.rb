class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, :all
      can :create, Post
      can :create, Like

      can :destroy, Post do |post|
        post.author_id == user.id
      end
      can :destroy, Comment do |comment|
        comment.author_id == user.id
      end

      can :destroy, Like do |like|
        like.author_id == user.id
      end
    end
  end
end
