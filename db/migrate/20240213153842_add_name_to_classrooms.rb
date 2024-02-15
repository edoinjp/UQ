class AddNameToClassrooms < ActiveRecord::Migration[7.0]
  def change
    add_column :classrooms, :name, :string
  end
end
