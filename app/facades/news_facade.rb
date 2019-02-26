class NewsFacade

  def is_favorite?(url)
    Favorite.where({url: url}).exists?
  end

  def articles
    response = Faraday.get("https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}")
    body = JSON.parse(response.body, :symbolize_names => true)
    return body[:articles]
  end

end