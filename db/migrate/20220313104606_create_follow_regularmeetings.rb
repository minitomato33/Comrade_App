class CreateFollowRegularmeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_regularmeetings do |t|
      t.integer :meeting_id
      t.integer :user_id
      t.integer :meeting_status

      t.timestamps
    end
  end
end
