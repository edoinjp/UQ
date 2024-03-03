class Chatroom < ApplicationRecord
  belongs_to :classroom
  has_many :messages
  has_many :direct_messages
  has_many :chatroom_users
  has_many :users , through: :chatroom_users
end
