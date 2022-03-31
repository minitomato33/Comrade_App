class SurvfieldsController < ApplicationController
  def index
    # GooglePlacesを使用してのフィールド情報取得
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    # 検索パラメタがある場合そのパラメタをもとに検索とDBへの登録
    if params[:search].nil?||params[:search].empty?
      #登録済フィールド取得
      @survfields = WentSurvfield.get_accessor(current_user.id)
    else
      @search = params[:search]
      #APIでの情報取得処理
      result = client.spots_by_query(@search + ' サバイバルゲームフィールド', types: 'point_of_interest', language: 'ja', multipage: true)
      @survfields = Survfield.get_GooglePlaces_spots_by_params(result,current_user.id)
      #ChIJEeELEJiPImAR0Kq99Aq-SsY
    end
    if @survfields
      @survfields = Kaminari.paginate_array(@survfields).page(params[:page])
    end  
  end

  def show
    # GooglePlacesを使用してのフィールド情報取得（一覧で詳細を取得できないため）
    place_id = params[:place_id]
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY']) 
    @survfield = Survfield.find_by(place_id: place_id)
    if @survfield.nil?
      #登録がない場合はAPIで取得(一覧では詳細を取得できていないため)
      result = client.spot(place_id, language: 'ja')
      @survfield = Survfield.get_GooglePlaces_spot_param(result,current_user.id)
    else
      @survfield = Survfield.set_accessor(@survfield,current_user.id)
    end
    gon.survfield = @survfield
  end
end
