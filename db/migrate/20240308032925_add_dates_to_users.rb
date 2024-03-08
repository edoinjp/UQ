class AddDatesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :date, :date
  end
end
