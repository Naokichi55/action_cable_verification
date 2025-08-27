class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :body

      #外部キーを設定
      t.references :user, foreign_key: true
      t.references :racket, foreign_key: true

      t.timestamps
    end
  end
end
