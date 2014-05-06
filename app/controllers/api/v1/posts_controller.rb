module Api
  module V1
    class PostsController < ApplicationController
      
      respond_to :json

      def index
        respond_with Post.all.order('title ASC')
      end
          
    end
  end
end