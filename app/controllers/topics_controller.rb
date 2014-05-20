class TopicsController < ApplicationController

  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def show
    authorize @topic
    @posts = @topic.posts.includes(:user).includes(:comments).paginate(page: params[:page], per_page: 10)
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.create(topic_params)
    authorize @topic
    if @topic.save
      redirect_to @topic, notice: "Created #{@topic.name}"
    else
      flash[:error] = "Error creating Topic. Please try again"
      render :new
    end
  end

  def edit
    authorize @topic
  end

  def update
    authorize @topic
    if @topic.update(topic_params)
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again"
      render :edit
    end
  end

  def destroy
    name = @topic.name

    authorize @topic
    if @topic.destroy
      redirect_to topics_path, notice: "\"#{name}\" was deleted"
    else
      render :show, notice: "there was an error deleting the topic"
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

end