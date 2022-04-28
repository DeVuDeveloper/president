class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(text: comment_params[:text], author_id: current_user.id, post_id: @post.id)

    if @comment.save
      flash[:notice] = 'Comment has been created successfully'
      redirect_to user_path(@comment.author.id), notice: 'The comment has been created successfully.'
    else
      flash[:alert] = 'The comment adding failed.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
