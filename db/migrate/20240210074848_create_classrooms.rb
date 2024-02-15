class CreateClassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :classrooms do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title  #line for the title attribute

      t.timestamps
    end
  end
end
