class Question < ApplicationRecord
  belongs_to :lesson
  has_many :choices , dependent: :destroy
end
