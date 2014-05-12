class TopicsController < ApplicationController

  before_action :set_topic, only: [:show, :edit, :update]

  def index
    @topics = Topic.all
    authorize @topics
  end

  def show
    authorize @topic
    @posts = @topic.posts
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

  private

  def topic_params
    params.require(:topic).permit!
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end