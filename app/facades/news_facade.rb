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
    # add age of article
    article_age = unique_title.map do |article| 
      article.update({age: convertDateToAge(article[:publishedAt])})
    end
    return article_age
  end

  def convertDateToAge(date)
    current_time = Time.now.utc.to_s;
    article_time = DateTime.strptime(date).to_s;
    seconds = Time.parse(current_time) - Time.parse(article_time);
    hours = (seconds / 3600).round
    days = (hours / 24).round
    weeks = (days / 7).round
    if weeks > 1
      return weeks.to_s + " weeks ago"
    elsif weeks == 1
      return weeks.to_s + " week ago"
    elsif days > 1
      return days.to_s + " days ago"
    elsif days == 1
      return days.to_s + " day ago"
    elsif hours > 1
      return hours.to_s + " hours ago"
    elsif hours == 1
      return hours.to_s + " hour ago"
    else
      return "Less than an hour ago."
    end
  end

  def news
    response = Faraday.get("https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}")
    body = JSON.parse(response.body, :symbolize_names => true)
    return body[:articles]
  end

end