class Comment < ApplicationRecord
  # アソシエーションを記載
  belongs_to :user
  belongs_to :racket

  # コメントのバリデーション設定
  validates :body, presence: true, length: { maximum: 65_535 }
end
