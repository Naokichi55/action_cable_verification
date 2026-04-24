class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :racket

  validates :user_id, uniqueness: { scope: :racket_id }
end
