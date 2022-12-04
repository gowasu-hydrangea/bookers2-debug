class BookComment < ApplicationRecord
  
  # ア・２＞18章
  # コメント機能の実装
  # UserモデルとBookCommentモデルを関連付ける（BookCommentモデルへの記述）
  belongs_to :user
  belongs_to :book
end
