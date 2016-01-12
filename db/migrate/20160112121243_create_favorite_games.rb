class CreateFavoriteGames < ActiveRecord::Migration
  def change
    create_table :favorite_games do |t|
      t.integer :game_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
