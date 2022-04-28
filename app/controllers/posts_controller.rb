class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments, :likes).find(params[:id])
  end

  def new
    @current_user = current_user
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'The post have been created successfully.'
      redirect_to user_path(@post.author_id, @post.id)
    else
      flash[:alert] = 'Adding a new post failed.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
