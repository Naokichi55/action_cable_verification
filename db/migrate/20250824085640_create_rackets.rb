class CreateRackets < ActiveRecord::Migration[7.2]
  def change
    create_table :rackets do |t|
      t.timestamps
    end
  end
end
