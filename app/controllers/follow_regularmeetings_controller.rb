class FollowRegularmeetingsController < ApplicationController
  def create
    meeting_id = params[:id]
    follow_regularmeetings = FollowRegularmeeting.new(meeting_id: meeting_id, user_id: current_user.id, meeting_status: 1)
    follow_regularmeetings.save!
    #リダイレクト
    redirect_back(fallback_location: root_path)
  end
  def destroy
    meeting_id = params[:id]
    user_id = params[:user_id]
    follow_regularmeetings = FollowRegularmeeting.find_by(meeting_id: meeting_id, user_id: user_id)
    follow_regularmeetings.destroy!
    #リダイレクト
    redirect_back(fallback_location: root_path)
  end
  def update
    meeting_id = params[:id]
    user_id = params[:user_id]
    follow_regularmeetings = FollowRegularmeeting.find_by(meeting_id: meeting_id, user_id: user_id)
    follow_regularmeetings.update(meeting_status: 2)
    #リダイレクト
    redirect_back(fallback_location: root_path)
  end
end
