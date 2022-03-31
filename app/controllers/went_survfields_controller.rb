class WentSurvfieldsController < ApplicationController
  def index
    if params[:field_user_id] ||= false 
      user_id = params[:field_user_id]
    else
      user_id = current_user.id
    end
    @survfields = WentSurvfield.get_accessor(user_id)
    @user = User.get_user_info(user_id,current_user.id)
    @center_survfield = Survfield.find_by(place_id: params[:is_center_field]) 
    #もしパラメタがおくられてきたら
    gon.center_survfield = @center_survfield
    gon.survfields = @survfields
  end

  def create
    place_id = params[:place_id]
    #データベースに格納
    if Survfield.find_by(place_id: place_id).nil?
      if params[:field_name].nil?
        #一覧から登録の場合詳細情報が不足するためAPIより取得し直して登録する。
        client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
        result = client.spot(place_id, language: 'ja')
        params = Survfield.get_GooglePlaces_spot_param(result,current_user.id)
      end
      survfield = Survfield.get_param_survfield(params)
      survfield.save!
    end
    went_survfield = WentSurvfield.new(user_id: current_user.id, place_id: place_id)
    went_survfield.save!
    #リダイレクト
    redirect_back(fallback_location: root_path)
  end

  def destroy
    went_survfield = WentSurvfield.find_by(place_id: params[:id], user_id: current_user.id)
    went_survfield.destroy!
    redirect_back(fallback_location: root_path)
  end
end
