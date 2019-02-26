class FavoritesFacade

  def articles
    Favorite.all.order("published_at DESC")
  end

end