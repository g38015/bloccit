module Api
  module V1
    class TopicsController < ApplicationController
      
      respond_to :json

      def index
        respond_with Topic.all
      end

      def show
        @topic = Topic.find(params[:id])
        @posts = @topic.posts
        respond_with @posts
      end
          
    end
  end
end