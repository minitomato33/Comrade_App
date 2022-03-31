class ChangeDatatypePlaceIdOfWentSurvfields < ActiveRecord::Migration[6.1]
  def change
    change_column :went_survfields, :place_id, :string
  end
end
