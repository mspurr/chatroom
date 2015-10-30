class DropFriendshipsTable < ActiveRecord::Migration
  def change
    def up
      drop_table :friendships
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
