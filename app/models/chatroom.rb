class Chatroom < ApplicationRecord
  belongs_to :classroom
  has_many :messages
  has_many :direct_messages
end
