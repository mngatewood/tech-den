require 'uri'

class NewsFacade

  include DatetimeHelper

  def is_favorite?(url)
    Favorite.where({url: url}).exists?
  end

  def articles
    unique_articles = remove_duplicate_articles(news)
    articles_with_age = unique_articles.map do |article| 
      # add age key/value to each article
      article.update({
        age: DatetimeHelper.convertDateToAge(article[:publishedAt]),
        urlToImage: add_thumbnail(article[:urlToImage])
      })
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

  def add_thumbnail(image)
    default_thumbnail = "https://images.unsplash.com/photo-1507071093492-031551ef451c?ixlib=rb-1.2.1&auto=format&fit=crop&w=256&q=80"
    return image ? image : default_thumbnail
  end

  def news
    response = Faraday.get("https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}")
    body = JSON.parse(response.body, :symbolize_names => true)
    return body[:articles]
  end

end