class Book < ApplicationRecord
  # has_many :user
  # ア・２＞9章
  # アソシエーション
  belongs_to :user
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
