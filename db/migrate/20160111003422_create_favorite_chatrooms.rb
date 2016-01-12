class CreateFavoriteChatrooms < ActiveRecord::Migration
  def change
    create_table :favorite_chatrooms do |t|
      t.integer :chatroom_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
