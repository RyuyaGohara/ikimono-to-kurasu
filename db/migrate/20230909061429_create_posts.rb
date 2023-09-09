class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      # 投稿のタイトル
      t.string :title
      # 投稿本文用
      t.text :body
      # 投稿したユーザーを識別
      t.integer :user_id

      t.timestamps
    end
  end
end
