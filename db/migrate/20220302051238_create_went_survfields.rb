class CreateWentSurvfields < ActiveRecord::Migration[6.1]
  def change
    create_table :went_survfields do |t|
      t.integer :user_id
      t.integer :field_id

      t.timestamps
    end
  end
end
