class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :image
      t.string :title
      t.string :source_name
      t.datetime :published_at
      t.string :url

      t.timestamps
    end
  end
end
