class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    authorize @posts
  end

  def show
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic

    authorize @post
    if @post.save
      redirect_to [@topic, @post], notice: "Created #{@post.title}"
    else
      flash[:error] = 'Error saving post, please try again'
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])

    authorize @post
    if @post.update(post_params)
      redirect_to [@topic, @post], notice: 'Updated'
    else
      flas[:error] = "Error saving post, please try again"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])

    title = @post.title
    authorize @post
    if @post.destroy
      redirect_to @topic, notice: "\"#{title}\" was deleted"
    else
      render :show, notice: "error deleting post"
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end
end