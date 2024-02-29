class CreateDirectMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :direct_messages do |t|
      t.text :content
      t.references :sender, foreign_key: { to_table: :users }
      t.references :recipient, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
