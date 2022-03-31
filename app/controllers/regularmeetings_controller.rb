class RegularmeetingsController < ApplicationController
  def index
    if params[:disp_plan].nil?
      # 募集一覧
      # フィールド検索処理
      # 検索処理行っているか
      if params[:search].nil?
        # 検索処理を行なっていない場合は全件表示
        @regularmeetings = Regularmeeting.where.not(user_id: current_user.id)
      else
        # 検索文字が存在するか
        if params[:search].empty?
          # 検索文字が存在しない場合は全件表示
          @regularmeetings = Regularmeeting.where.not(user_id: current_user.id)
        else
          # フィールド情報より検索結果を取得
          fields = Survfield.where("field_name like?" , "%#{params[:search]}%")
          # フィールドは取得できたか
          if fields.present?
            place_ids = []
            # 取得フィールドのplace_idを配列化
            fields.each do |field|
              place_ids << field.place_id
            end
            #フィールド検索で取得した全てのplaceidを検索値として定例会情報取得
            @regularmeetings = Regularmeeting.where(place_id: place_ids).where.not(user_id: current_user.id)
          else
            #フィールドが取得できなかった場合は定例会情報作成なし
          end
        end
      end
    else 
      # 企画一覧
      @regularmeetings = Regularmeeting.where(user_id: current_user.id) 
      @disp_plan = params[:disp_plan]
    end
    #定例会情報取得できた場合のみ処理
    if @regularmeetings.present?
      @regularmeetings = Regularmeeting.get_accessor(@regularmeetings,current_user.id)
      if params[:disp_plan].nil?
        @regularmeetings = Regularmeeting.get_valid_accessor(@regularmeetings)
      end
    else
      #定例会情報が存在しない場合にkaminaiで落ちないようにダミー作成
      @regularmeetings = []
    end
    @regularmeetings = Kaminari.paginate_array(@regularmeetings).page(params[:page])
  end

  def show
    @disp_delete = params[:disp_delete]
    @regularmeeting = Regularmeeting.set_accessor(Regularmeeting.find(params[:id]),current_user.id)
    followRegularmeetings = FollowRegularmeeting.where(meeting_id: @regularmeeting.id)
    @users = FollowRegularmeeting.get_users_accessor(followRegularmeetings,current_user.id)
    @users = Kaminari.paginate_array(@users).page(params[:page])
  end

  def new
    @wentsurvfields = WentSurvfield.get_accessor(current_user.id)
    @regularmeeting = Regularmeeting.new
  end

  def create
		regularmeeting = Regularmeeting.new(params.require(:regularmeeting).permit(:title, :place_id, :participation_day, :transportation, :playstyle, :appeal))
		regularmeeting.user_id = current_user.id
		regularmeeting.save!
    #FollowRegularmeeting側の登録
    follow_regularmeeting = FollowRegularmeeting.new(meeting_id: regularmeeting[:id], user_id: current_user.id, meeting_status: 2)
    follow_regularmeeting.save!
    #リダイレクト
    redirect_to regularmeetings_path(disp_plan: 'on')
  end
  
  def edit
    @wentsurvfields = WentSurvfield.get_accessor(current_user.id)
    @regularmeeting = Regularmeeting.find(params[:id])
  end

  def update
		regularmeeting = Regularmeeting.find(params[:id])
		regularmeeting.update!(params.require(:regularmeeting).permit(:title, :place_id, :participation_day, :transportation, :playstyle, :appeal))
    #リダイレクト
    redirect_to regularmeetings_path(disp_plan: 'on')
  end

  def destroy
    regularmeeting = Regularmeeting.find(params[:id])
    regularmeeting.destroy
    #リダイレクト
    redirect_to regularmeetings_path(disp_plan: 'on')
  end
end
