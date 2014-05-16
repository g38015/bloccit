class FavoritesController < ApplicationController

  def create
     @topic = Topic.friendly.find(params[:topic_id])
     @post = @topic.posts.find(params[:post_id])
     favorite = current_user.favorites.build(post: @post)

     authorize favorite
     if favorite.save
       redirect_to [@topic, @post], notice: "Favorited Post"
     else
       flash[:error] = 'Unalbe to favorite please try again'
       redirect_to [@topic, @post]
     end
  end

  def destroy
    @topic = Topic.friendly.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    authorize favorite
    if favorite.destroy
      flash[:notice] = "Removed Favorite"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to remove favorite"
      redirect_to [@topic, @post]
    end
  end

end