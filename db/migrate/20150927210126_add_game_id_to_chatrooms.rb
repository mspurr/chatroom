class AddGameIdToChatrooms < ActiveRecord::Migration
  def change
    add_column :chatrooms, :game_id, :integer
  end
end
