class AddStarToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :star, :string
  end
end
