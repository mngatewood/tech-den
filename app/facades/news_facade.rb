class NewsFacade

  include DatetimeHelper

  def is_favorite?(url)
    Favorite.where({url: url}).exists?
  end

  def articles
    unique_articles = remove_duplicate_articles(news)
    # add age key/value to each article
    articles_with_age = unique_articles.map do |article| 
      article.update({age: DatetimeHelper.convertDateToAge(article[:publishedAt])})
    end
    return articles_with_age
  end

  def remove_duplicate_articles(articles)
    # remove duplicate URLs
    unique_urls = articles.uniq {|article| article[:url]}
    # remove duplicate titles
    unique_titles = unique_urls.uniq {|article| article[:title]}
    return unique_titles
  end

  def news
    response = Faraday.get("https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}")
    body = JSON.parse(response.body, :symbolize_names => true)
    return body[:articles]
  end

end