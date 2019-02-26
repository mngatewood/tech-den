class NewsController < ApplicationController

  def index
    @facade = NewsFacade.new()
  end
  
end