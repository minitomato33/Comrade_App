class AddColumnToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :afollow_status, :integer
  end
end
