class AddSupplementaryToStyledLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :styled_lessons, :supplementary, :boolean
  end
end
