class CreateRackets < ActiveRecord::Migration[7.2]
    def change
    create_table :rackets do |t|
      # product_nameとmaker_name null:falseを記載
      t.string :product_name, null: false
      t.string :maker_name,  null: false
      t.integer :face_size
      t.string :main_string
      t.string :cross_string
      t.integer :main_string_tension
      t.integer :cross_string_tension
      t.string :weight_position
      t.integer :grip_size
      t.string :grip_tape
      t.text :body

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
