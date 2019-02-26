require 'rails_helper'

RSpec.describe Favorite, type: :model do

  describe "Validations" do
    it {should validate_presence_of(:image)}
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:source_name)}
    it {should validate_presence_of(:published_at)}
    it {should validate_presence_of(:url)}
    it {should validate_uniqueness_of(:url)}
  end

  describe "Methods" do
  end


end
