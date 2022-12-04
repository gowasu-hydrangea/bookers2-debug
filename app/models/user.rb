class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # belongs_to :books
  has_one_attached :profile_image
  
  has_many :books, dependent: :destroy
  # ア・２＞18章
  # コメント機能の実装
  # UserモデルとBookCommentモデルを関連付ける（Userモデルへの記述）
   has_many :book_comments, dependent: :destroy
  
  # ア・２＞19章
  # いいね機能の実装
  # Userモデルに関連付けを追加する
  has_many :favorites, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,
  length: { maximum: 50 }

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
