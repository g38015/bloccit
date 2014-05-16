class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.friendly.find(params[:post_id])
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
    @topic = Topic.friendly.find(params[:topic_id])
    @post = @topic.posts.friendly.find(params[:post_id])
    
    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = 'Comment was removed'
    else
      flash[:error] = 'Comment was not deleted'
    end

    respond_with(@comment) do |f|
      f.html {redirect_to [@topic, @post]}
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end