class Favorite < ApplicationRecord

  validates_presence_of :image,
                        :title,
                        :source_name,
                        :published_at,
                        :url

  validates_uniqueness_of :url

end