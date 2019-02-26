require 'rails_helper'

feature "user sees news index page" do
  context "unregistered user" do
    scenario "visits the root page" do
      VCR.use_cassette("newsapi_service_spec", record: :all) do
        #  As an unregistered user
        #  When I visit the root page
        visit '/'
        expect(current_path).to eq("/")
        expect(page).to have_content("Tech-DEN")

        # I see a list of news articles related to technology in Denver

        expect(page).to have_css('article.article-container', count: 14)

      # Each article includes a title, content, source, image, url, and publishedAt

        within(first('article.article-container')) do
          expect(page).to have_css('.article-title')
          expect(page).to have_css('.article-image')
          expect(page).to have_css('.article-source')
          expect(page).to have_css('.article-published-at')
        end

      end
    end
  end
end
