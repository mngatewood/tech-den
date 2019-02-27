require 'rails_helper'

feature "user sees favorites index page" do
  context "unregistered user" do
    scenario "visits the favorites page" do

      stub_request(:get, "https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}").
        to_return(body: File.read("./spec/fixtures/news_api_response.json"))

      # Setup test with three favorites
      visit '/'
      within(all('.add-favorite-container')[0]) do
        click_link('Add to Favorites')
      end

      visit '/'
      within(all('.add-favorite-container')[1]) do
        click_link('Add to Favorites')
      end

      visit '/'
      within(all('.add-favorite-container')[2]) do
        click_link('Add to Favorites')
      end

      # As a user,
      # When I visit the favorites page,
      visit "/favorites"

      # I see a link with each favorite article that reads "Delete Favorite".
      expect(page).to have_css("article.article-container", count: 3)
      expect(page).to have_css(".delete-favorite", count: 3)
      expect(page).to have_content("Delete Favorite", count: 3)

      # When I click the link,
      within(all('article.article-container')[0]) do
        click_link('Delete Favorite')
      end

      # I see a message that reads "Successfully removed article from favorites." AND
      expect(page).to have_content("Successfully deleted favorite.")

      # That article is no longer displayed on the favorites page.
      expect(current_path).to eq("/favorites")
      expect(page).to have_css("article.article-container", count: 2)
    end
  end
end



