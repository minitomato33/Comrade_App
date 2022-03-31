class RenameFieldIdColumnToWentSurvfields < ActiveRecord::Migration[6.1]
  def change
    rename_column :went_survfields, :field_id, :place_id
  end
end
