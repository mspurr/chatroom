class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :content
      t.integer :user, index: true
      t.integer :sender
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
