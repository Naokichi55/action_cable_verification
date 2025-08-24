class Racket < ApplicationRecord
  belongs_to :user

  # ラケット投稿機能アソシエーション
  has_many_attached :images
  # commentテーブルとのアソシエーション
  has_many :comments, dependent: :destroy

  # ラケット投稿機能のバリデーション
  validates :product_name, presence: true, length: { maximum: 255 }
  validates :maker_name, presence: true, length: { maximum: 255 }
  validates :face_size, inclusion: { in: 1..200 }, allow_blank: true
  validates :main_string, length: { maximum: 255 }
  validates :cross_string, length: { maximum: 255 }
  validates :main_string_tension, inclusion: { in: 1..100 }, allow_blank: true
  validates :cross_string_tension, inclusion: { in: 1..100 }, allow_blank: true
  validates :grip_size, inclusion: { in: 1..20 }, allow_blank: true
  validates :grip_tape, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }

end
