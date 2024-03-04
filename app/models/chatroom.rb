class Chatroom < ApplicationRecord
  belongs_to :classroom
  has_many :messages, dependent: :destroy
  # has_many :direct_messages, dependent: :destroy
  has_and_belongs_to_many :users
end
