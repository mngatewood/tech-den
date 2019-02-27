class NewsFacade

  def is_favorite?(url)
    Favorite.where({url: url}).exists?
  end

  def articles
    return remove_duplicate_articles(news)
  end

  def remove_duplicate_articles(articles)
    # remove duplicate URLs
    unique_url = articles.uniq {|article| article[:url]}
    # remove duplicate titles
    unique_title = unique_url.uniq {|article| article[:title]}
    return unique_title
  end

  def news
    response = Faraday.get("https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}")
    body = JSON.parse(response.body, :symbolize_names => true)
    return body[:articles]
  end

end