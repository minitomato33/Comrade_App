class FollowsController < ApplicationController
 def create
    follow_id = params[:id]
    follower = Follow.new
    follower.user_id = current_user.id
    follower.follow_id = follow_id
    follower.follow_status = Follow::FOLLOW_STATUS_TYPE_REQUEST
    follower.save!

    followee = Follow.new
    followee.user_id = follow_id
    followee.follow_id = current_user.id
    followee.follow_status = Follow::FOLLOW_STATUS_TYPE_REQUEST_TO_YOU
    followee.save!
    redirect_back(fallback_location: root_path)
 end

 def update
    follow_id = params[:id]
    user_id = current_user.id
    follower = Follow.find_by(user_id: user_id, follow_id: follow_id)
    follower.update(follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING)

    followee = Follow.find_by(user_id: follow_id, follow_id: user_id)
    followee.update(follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING)

    redirect_back(fallback_location: root_path)
 end
 def destroy
    follow_id = params[:id]
    user_id = current_user.id
    
    follower = Follow.find_by(user_id: user_id, follow_id: follow_id)
    follower.destroy!

    followee = Follow.find_by(user_id: follow_id, follow_id: user_id)
    followee.destroy!

    redirect_back(fallback_location: root_path)
 end
end

