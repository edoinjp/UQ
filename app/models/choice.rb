class Choice < ApplicationRecord
  belongs_to :question
  has_many :responses, dependent: :destroy
end
