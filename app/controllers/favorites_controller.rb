class FavoritesController < ApplicationController

  def index
    @facade = FavoritesFacade.new()
  end

  def create
    favorite = Favorite.new(new_favorite_params)
    if favorite.save
      flash[:success] = "Successfully added article to favorites."
    else
      flash[:error] = "Unable to add article to favorites."
    end
    redirect_to root_path
  end

  def destroy
    favorite = Favorite.find(delete_favorite_params[:id])
    if favorite.delete
      flash[:success] = "Successfully deleted favorite."
    else
      flash[:error] = "Unable to delete favorite."
    end
    redirect_to favorites_path

  end

  private

  def new_favorite_params
    params.require(:favorite).permit(:image, :title, :source_name, :published_at, :url)
  end

  def delete_favorite_params
    params.require(:favorite).permit(:id)
  end
  
end