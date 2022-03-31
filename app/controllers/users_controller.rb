class UsersController < ApplicationController
  def index
      @users =  if params[:search].nil? && params[:disp_similar].nil?
                  User.where.not(id: current_user) 
                elsif params[:disp_similar].present?
                  User.get_similar_user(current_user.id)
                else
                  User.where("account_name like?" , "%#{params[:search]}%").where.not(id: current_user.id)
                end
    # 表示されたユーザーのフォロー状態を取得する。
    @users = Follow.get_follow_status(@users,current_user.id)
    @users = Kaminari.paginate_array(@users).page(params[:page])
    if params[:disp_similar].present?
      @disp_similar = params[:disp_similar]
    end
  end

  def show
    #  パラメタが設定された場合自分のプロフィール、そうでない場合はIDで設定ユーザー情報取得
    @user = if params[:id].nil?
              User.get_user_info(current_user.id,current_user.id)
            else
              User.get_user_info(params[:id],current_user.id)
            end
            
    #  対象ユーザのフォロー情報を取得
    @followings = Follow.get_follow_status(@user,current_user.id)
    @followings = Kaminari.paginate_array(@followings).page(params[:page])
    @followings.sort_by { |u| u.followers_count }.reverse

    # 参加済サバゲーフィールドの情報を取得
    @went_survfields = WentSurvfield.get_accessor(@user)
    @went_survfields = Kaminari.paginate_array(@went_survfields).page(params[:page])

    # 企画定例会を表示
    @regularmeetings = Regularmeeting.where(user_id: @user) 
    @regularmeetings = Regularmeeting.get_accessor(@regularmeetings,current_user.id)
    # 本人ではない場合は期限切れを省く
    if @user.id != current_user.id
      @regularmeetings = Regularmeeting.get_valid_accessor(@regularmeetings)
    end
    @regularmeetings = Kaminari.paginate_array(@regularmeetings).page(params[:page])

    # 参加定例会を表示
    #followsを取得
    followRegularmeetings = FollowRegularmeeting.where(user_id: @user)
    #meeting_idで定例会をを取得
    meeting_id = []
    if followRegularmeetings.present?
      followRegularmeetings.each do |followRegularmeeting|
        meeting_id = followRegularmeeting.meeting_id
      end
    end
    @go_regularmeetings = Regularmeeting.where(id: meeting_id).where.not(user_id: @user)
    @go_regularmeetings = Regularmeeting.get_accessor(@go_regularmeetings,current_user.id)
    @go_regularmeetings = Regularmeeting.get_valid_accessor(@go_regularmeetings)
    @go_regularmeetings = Kaminari.paginate_array(@go_regularmeetings).page(params[:page])    
    @disp = params[:disp]
  end
end
