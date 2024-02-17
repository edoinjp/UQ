class Response < ApplicationRecord
  belongs_to :user
  belongs_to :choice
  has_one_attached :photo
end
