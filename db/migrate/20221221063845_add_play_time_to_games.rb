class AddPlayTimeToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :play_time, :string
  end
end
