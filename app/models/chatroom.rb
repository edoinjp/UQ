class Chatroom < ApplicationRecord
  belongs_to :classroom
  has_many :messages, dependent: :destroy
  has_many :chatroom_users
  has_many :chatroom, through: :chatroom_users
  has_many :users, through: :chatroom_users
end
