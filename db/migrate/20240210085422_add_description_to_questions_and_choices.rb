class AddDescriptionToQuestionsAndChoices < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :description, :string
    add_column :choices, :description, :string
  end
end
