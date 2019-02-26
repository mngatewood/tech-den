require 'rails_helper'

feature "user sees news index page" do
  context "unregistered user" do
    scenario "visits the root page" do

    #  As an unregistered user
    #  When I visit the root page
    visit '/'
    expect(current_path).to eq("/")
    expect(page).to have_content("Tech-DEN")

    # I see a list of news articles related to technology in Denver

    # Each article includes a title, content, source, image, url, and publishedAt

    # Articles are sorted by publishedAt, descending.

    end
  end
end
