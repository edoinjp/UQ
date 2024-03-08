class AddDateToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :date, :date
  end
end
