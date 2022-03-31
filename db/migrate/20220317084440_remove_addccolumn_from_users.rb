class RemoveAddccolumnFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :age, :string
    remove_column :users, :sex, :string
    remove_column :users, :experience, :string
    remove_column :users, :participation, :string
    remove_column :users, :playstyle, :string
    remove_column :users, :holiday, :string
  end
end
