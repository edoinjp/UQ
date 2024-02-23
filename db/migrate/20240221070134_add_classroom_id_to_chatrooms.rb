class AddClassroomIdToChatrooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :classroom, null: false, foreign_key: true
  end
end
