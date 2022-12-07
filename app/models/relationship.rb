class Relationship < ApplicationRecord
  # ポ・基＞課題４
  # リレーションの書き方
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
