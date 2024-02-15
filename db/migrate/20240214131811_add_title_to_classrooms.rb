class AddTitleToClassrooms < ActiveRecord::Migration[7.0]
  def change
    add_column :classrooms, :title, :string
  end
end
