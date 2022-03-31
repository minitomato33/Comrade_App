class RenameAfollowStatusColumnToFollows < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :afollow_status, :follow_status
  end
end
