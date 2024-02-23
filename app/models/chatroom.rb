class Chatroom < ApplicationRecord
  belongs_to :classroom
  has_many :messages
end
