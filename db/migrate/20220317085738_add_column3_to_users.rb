class AddColumn3ToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :sex, :integer
    add_column :users, :experience, :integer
    add_column :users, :playstyle, :integer
    add_column :users, :holiday, :integer
  end
end
