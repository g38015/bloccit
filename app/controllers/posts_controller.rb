class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    authorize @posts
  end

  def show
    @topic = Topic.find(params[:topic_id])
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
    @post.destroy
    redirect_to root_path, notice: 'Destroyed'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end