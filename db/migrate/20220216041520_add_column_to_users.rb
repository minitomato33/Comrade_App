class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :account_name, :string
    add_column :users, :account_id, :string
    add_column :users, :image, :text
  end
end
