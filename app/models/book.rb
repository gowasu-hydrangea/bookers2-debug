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
  
  # ポ・基＞課題５
  # 検索機能の実装
  # 参考元
  # https://qiita.com/hapiblog2020/items/6c2cef49df5616da9ae3
  # 検索方法分岐
  def self.looks(search, word)
    # perfect_match＝完全一致
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    # forward_match＝前方一致
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    # backward_match＝後方一致
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    # perfect_match＝完全一致
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
