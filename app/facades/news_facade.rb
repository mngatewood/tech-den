class NewsFacade

  def initialize
    @start_date = self.start_date
    @end_date = self.end_date
  end

  def end_date
    return Date.current
  end

  def start_date
    return Date.current.advance(days: -7)
  end

  def articles
    response = Faraday.get("https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&from=#{@start_date}&to=#{@end_date}&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}")
    body = JSON.parse(response.body, :symbolize_names => true)
    return body[:articles]
  end




end