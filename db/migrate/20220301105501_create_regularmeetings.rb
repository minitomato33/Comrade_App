class CreateRegularmeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :regularmeetings do |t|
      t.integer :user_id
      t.string :title
      t.date :participation_day
      t.string :transportation
      t.string :playstyle
      t.string :appeal

      t.timestamps
    end
  end
end
