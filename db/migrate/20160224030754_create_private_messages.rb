class CreatePrivateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :private_messages do |t|
      t.references :user, index: true
      t.integer :sender, index: true
      t.text :content
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
