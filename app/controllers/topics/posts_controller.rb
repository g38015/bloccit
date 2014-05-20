module Topics
  class PostsController < ApplicationController

    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :set_topic, except: [:index]

    def index
      @posts = Post.all
      authorize @posts
    end

    def show
      authorize @topic
      @comments = @post.comments
      @comment = Comment.new
    end

    def new
      @post = Post.new
      authorize @post
    end

    def create
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
      authorize @post
    end

    def update
      authorize @post
      if @post.update(post_params)
        redirect_to [@topic, @post], notice: 'Updated'
      else
        flash[:error] = "Error saving post, please try again"
        render :edit
      end
    end

    def destroy
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
      @post = Post.friendly.find(params[:id])
    end

    def set_topic
      @topic = Topic.friendly.find(params[:topic_id])
    end
  end
end