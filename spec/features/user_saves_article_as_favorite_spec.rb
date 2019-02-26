require 'rails_helper'

feature "user saves an article as a favorite" do
  context "unregistered user" do
    scenario "clicks 'add to favorites'" do
      stub_request(:get, "https://newsapi.org/v2/everything?q=%22denver%20technology%22%20OR%20%22denver%20tech%22&sortBy=publishedAt&apiKey=#{ENV['NEWS_API_KEY']}").
        to_return(body: File.read("./spec/fixtures/news_api_response.json"))

      # As an unregistered user,
      # When I visit the root page,
      visit '/'

      # I see a link with each article that reads "Add to Favorites".
      within(first('article.article-container')) do
        expect(page).to have_css('.add-favorite-container', count: 1)
      end
      
      within(first('.add-favorite-container')) do
        expect(page).to have_link(count: 1)
        expect(page).to have_css('.add-favorite')
        expect(page).to have_content('Add to Favorites')     
      end

      # When I click the link,
      within(first('.add-favorite-container')) do
        click_link('Add to Favorites')
      end

      # I see a message that reads "Successfully added article to favorites."
      expect(page).to have_content('Successfully added article to favorites.')
      
      # Where the link was, I now see a text element that reads "Added to Favorites".
      within(first('.add-favorite-container')) do
        expect(page).to have_css('.add-favorite')
        expect(page).to have_content('Added to Favorites')     
        expect(page).to_not have_link('Add to Favorites')     
      end

      #If the save fails, 
      within(all('.add-favorite-container').last) do
        click_link('Add to Favorites')
      end

      # I see a message that reads "Unable to add article to favorites."
      expect(page).to have_content('Unable to add article to favorites.')

      within(all('.add-favorite-container').last) do
        expect(page).to have_css('.add-favorite')
        expect(page).to_not have_content('Added to Favorites')     
        expect(page).to have_link('Add to Favorites')     
      end

    end
  end
end
