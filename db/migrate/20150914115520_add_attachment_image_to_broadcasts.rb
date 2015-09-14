class AddAttachmentImageToBroadcasts < ActiveRecord::Migration
  def self.up
    change_table :broadcasts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :broadcasts, :image
  end
end
