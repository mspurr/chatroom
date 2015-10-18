class AddCachedVotesToBroadcasts < ActiveRecord::Migration
  def self.up
    add_column :broadcasts, :cached_votes_total, :integer, :default => 0
  end

  def self.down
    remove_column :broadcasts, :cached_votes_total
  end
end
