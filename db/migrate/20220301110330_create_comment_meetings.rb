class CreateCommentMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_meetings do |t|
      t.integer :meeting_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
