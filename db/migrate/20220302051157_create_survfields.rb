class CreateSurvfields < ActiveRecord::Migration[6.1]
  def change
    create_table :survfields do |t|
      t.string :field_name
      t.float :lat
      t.float :lng
      t.string :phone_number
      t.string :address
      t.string :icon
      t.string :website

      t.timestamps
    end
  end
end
