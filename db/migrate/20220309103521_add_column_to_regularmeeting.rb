class AddColumnToRegularmeeting < ActiveRecord::Migration[6.1]
  def change
    add_column :regularmeetings, :place_id, :string
  end
end
