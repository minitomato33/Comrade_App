class FollowRegularmeeting < ApplicationRecord
  #アソシエーション
  belongs_to :user 
  belongs_to :regularmeeting, foreign_key: 'meeting_id' 

  def self.get_follow_status(regularmeeting_id,user_id)
    if regularmeeting_id.present?
      followregularmeeting = FollowRegularmeeting.find_by(meeting_id: regularmeeting_id,user_id: user_id)
      if followregularmeeting.nil?   
        follow_status = 0
      else
        follow_status = followregularmeeting.meeting_status
      end
    end
    follow_status
  end
  def self.get_users_accessor(followRegularmeetings,current_user_id)
    users = []
    followRegularmeetings.each do |followRegularmeeting|
      user = User.get_user_info(followRegularmeeting[:user_id],current_user_id)
      user = User.set_accessor(user, current_user_id)
      users << User.set_meetingstatus_accessor(user,followRegularmeeting)
    end
    users
  end
end
