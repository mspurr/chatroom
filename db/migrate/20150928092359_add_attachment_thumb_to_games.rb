class AddAttachmentThumbToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.attachment :thumb
    end
  end

  def self.down
    remove_attachment :games, :thumb
  end
end
