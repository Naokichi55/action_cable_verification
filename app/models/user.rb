class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rackets, dependent: :destroy
  # commentテーブルとのアソシエーションを記載
  has_many :comments, dependent: :destroy

  # emailに関するバリデーション
  validates :email, presence: true, uniqueness: true
  # nameに関するバリデーション
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }


  # 投稿者とログインユーザーが同じかを確認
  def own?(object)
    id == object&.user_id
  end
end