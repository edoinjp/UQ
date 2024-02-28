class AddContentToLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :lessons, :content, :text
  end
end
