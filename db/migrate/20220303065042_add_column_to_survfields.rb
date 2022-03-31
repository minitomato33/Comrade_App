class AddColumnToSurvfields < ActiveRecord::Migration[6.1]
  def change
    add_column :survfields, :place_id, :string
  end
end
