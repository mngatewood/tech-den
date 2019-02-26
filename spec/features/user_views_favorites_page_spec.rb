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
      # When I visit the root page,
      visit '/'
      expect(current_path).to eq("/")

      # I see a link that reads "View Favorites".
      expect(page).to have_link("View Favorites")

      # When I click on the link,
      click_on("View Favorites")

      # I am redirected to a favorites page, AND
      expect(current_path).to eq("/favorites")
      
      # I see all of the articles I saved as a favorite, AND
      expect(page).to have_css("article.article-container", count: 3)
      
      # The articles I see on the favorites page render similar to how they render on the root page.
      within(first('article.article-container')) do
        expect(page).to have_css('.article-title')
        expect(page).to have_css('.article-image')
        expect(page).to have_css('.article-source')
        expect(page).to have_css('.article-published-at')
      end

      # I see a link that reads "Return to articles".
      expect(page).to have_link("Return to Articles")

      # When I click the return to articles link,
      click_on("Return to Articles")

      # I am redirected to the root page and see a list of all articles.
      expect(current_path).to eq("/")

    end
  end
end