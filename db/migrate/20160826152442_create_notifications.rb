class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :body
      t.belongs_to :sender
      t.boolean :read

      t.timestamps
    end
  end
end
