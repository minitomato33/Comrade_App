class AddColumn2ToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :sex, :string
    add_column :users, :experience, :string
    add_column :users, :participation, :string
    add_column :users, :playstyle, :string
    add_column :users, :holiday, :string
    add_column :users, :memo, :string
  end
end
