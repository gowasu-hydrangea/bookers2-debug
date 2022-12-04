class Book < ApplicationRecord
  # has_many :user
  # ア・２＞9章
  # アソシエーション
  belongs_to :user
  
  # ア・２＞18章
  # コメント機能の実装
  # BookモデルとBookCommentモデルを関連付ける
   has_many :book_comments, dependent: :destroy
  # ア・２＞19章
  # いいね機能の実装
  # Bookモデルに関連付けを追加する
  has_many :favorites, dependent: :destroy
  # ア・２＞19章
  # いいね機能の実装
  # Bookモデルに関連付けを追加する
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
