class AddImageToStyledLessons < ActiveRecord::Migration[7.0]
  def change
    add_column :styled_lessons, :visual_image_url, :string
  end
end
