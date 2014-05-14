class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "created comment"
      redirect_to topic_post_path(@topic, @post)
    else
      flash[:error] = "comment did not save"
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end