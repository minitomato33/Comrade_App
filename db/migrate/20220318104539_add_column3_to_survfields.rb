class AddColumn3ToSurvfields < ActiveRecord::Migration[6.1]
  def change
    add_column :survfields, :formatted_phone_number, :string
  end
end
