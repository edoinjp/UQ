class AddScoresToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :score, :json, default: {}
  end
end
