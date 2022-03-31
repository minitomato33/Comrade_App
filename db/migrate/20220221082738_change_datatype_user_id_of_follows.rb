class ChangeDatatypeUserIdOfFollows < ActiveRecord::Migration[6.1]
  def change
    change_column :follows, :user_id, :'integer USING CAST(user_id AS integer)'
  end
end
