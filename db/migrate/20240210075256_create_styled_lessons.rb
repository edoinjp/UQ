class CreateStyledLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :styled_lessons do |t|
      t.string :style
      t.string :content
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
