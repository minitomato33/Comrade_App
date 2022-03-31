class AddColumn2ToSurvfields < ActiveRecord::Migration[6.1]
  def change
    add_column :survfields, :viewport, :string
    add_column :survfields, :types, :string
    add_column :survfields, :international_phone_number, :string
    add_column :survfields, :formatted_address, :string
    add_column :survfields, :address_components, :string
    add_column :survfields, :street_number, :string
    add_column :survfields, :street, :string
    add_column :survfields, :city, :string
    add_column :survfields, :region, :string
    add_column :survfields, :postal_code, :string
    add_column :survfields, :country, :string
    add_column :survfields, :rating, :string
    add_column :survfields, :price_level, :string
    add_column :survfields, :opening_hours, :string
    add_column :survfields, :url, :string
  end
end
