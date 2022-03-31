class AddColumn4ToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :participation, :integer
  end
end
