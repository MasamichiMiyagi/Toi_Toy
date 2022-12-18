class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :title
      t.text :body
      t.integer :customer_id
      t.timestamps
    end
  end
end
