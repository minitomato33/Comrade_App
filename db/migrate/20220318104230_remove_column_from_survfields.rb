class RemoveColumnFromSurvfields < ActiveRecord::Migration[6.1]
  def change
    remove_column :survfields, :phone_number, :string
    remove_column :survfields, :address, :string
    remove_column :survfields, :icon, :string
    remove_column :survfields, :types, :string
    remove_column :survfields, :international_phone_number, :string
    remove_column :survfields, :address_components, :string
    remove_column :survfields, :street_number, :string
    remove_column :survfields, :street, :string
    remove_column :survfields, :city, :string
    remove_column :survfields, :region, :string
    remove_column :survfields, :postal_code, :string
    remove_column :survfields, :country, :string
    remove_column :survfields, :price_level, :string
    remove_column :survfields, :opening_hours, :string
    remove_column :survfields, :url, :string
  end
end
