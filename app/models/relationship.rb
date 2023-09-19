class Relationship < ApplicationRecord

# フォローしたユーザー
  belongs_to :follower, class_name: "User"
# フォローされたユーザー
  belongs_to :followed, class_name: "User"
  # class_name: "User"でuserテーブルからデータを取得

end
