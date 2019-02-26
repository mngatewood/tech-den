class FavoritesController < ApplicationController

  def index
    @facade = FavoritesFacade.new()
  end

  def create
    favorite = Favorite.new(favorite_params)
    if favorite.save
      flash[:success] = "Successfully added article to favorites."
    else
      flash[:error] = "Unable to add article to favorites."
    end
    redirect_to root_path
  end

  private

  def favorite_params
    params.require(:favorite).permit(:image, :title, :source_name, :published_at, :url)
  end
  
end