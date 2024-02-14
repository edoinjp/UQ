class Question < ApplicationRecord
  belongs_to :lesson
<<<<<<< HEAD
  has_many :choices
=======
  has_many :choices , dependent: :destroy
>>>>>>> master
end
