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
  
  # ポ・基＞課題４
  # リレーションの書き方
  # xxxはアソシエーションが繋がっているテーブル名、class_nameは実際のモデルの名前、foreign_keyは外部キーとして何を持つかを表しています。
  # has_many :xxx, class_name: "モデル名", foreign_key: "○○_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # ↑参考元
  # https://qiita.com/nakachan1994/items/e6107fe3003f6515e385
  # フォローした・されたの関係
  
  # ポ・基＞課題４
  # リレーションの書き方
  #「has_many :テーブル名, through: :中間テーブル名」 の形を使って、テーブル同士が中間テーブルを通じてつながっていることを表現します。
  # =(followerテーブルとfollowedテーブルのつながりを表す）
  # 例えば、yyyにfollowedを入れてしまうと、followedテーブルから中間テーブルを通ってfollowerテーブルにアクセスすることができなくなってしまいます。
   #  これを防ぐためにyyyには架空のテーブル名を、zzzは実際にデータを取得しにいくテーブル名を書きます。
  # has_many :yyy, through: :xxx, source: :zzz
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # ↑参考元
  # https://qiita.com/nakachan1994/items/e6107fe3003f6515e385
  # 一覧画面で使う
  

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,
  length: { maximum: 50 }

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # フォロー・フォロワー機能の実装
  # 参考元：https://qiita.com/nakachan1994/items/e6107fe3003f6515e385
  # メソッド作成
  
  # フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
  # ポ・基＞課題５
  # 検索機能の実装
  # 参考元
  # https://qiita.com/hapiblog2020/items/6c2cef49df5616da9ae3
  # 検索方法分岐
  def self.looks(search, word)
    # perfect_match＝完全一致
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    # forward_match＝前方一致
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    backward_match＝後方一致
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    # perfect_match＝部分一致
    elsif search == "partial_match"
      @user = User.all
    end
  end
  
end
