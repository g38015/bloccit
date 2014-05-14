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

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      redirect_to [@topic, @post], notice: 'Comment was removed'
    else
      redirect_to [@topic, @post], notice: 'Comment was not deleted'
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end