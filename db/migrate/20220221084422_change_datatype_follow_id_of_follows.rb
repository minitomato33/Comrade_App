class ChangeDatatypeFollowIdOfFollows < ActiveRecord::Migration[6.1]
  def change
    change_column :follows, :follow_id, :'integer USING CAST(follow_id AS integer)'
  end
end
