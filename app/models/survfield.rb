class Survfield < ApplicationRecord
  #バリデーション
  validates :place_id, uniqueness: true
  #アソシエーション
  has_many :users, through: :wentsurvfield
  has_many :wentsurvfields, class_name: 'WentSurvfield', primary_key: 'place_id', foreign_key: 'place_id'
  has_many :regularmeetings, class_name: 'Regularmeetings', primary_key: 'place_id', foreign_key: 'place_id'

  # 定数
  WENTED = true
  NOWENT = false

  # accessor
  attr_accessor :wented_field_flg


  #GooglePlacesよりspots_byで取得した情報を格納
  def self.get_GooglePlaces_spots_by_params(params,current_user_id)
    survfields = []
    params.each do |param|
      survfield = Survfield.new
      survfield.place_id = param.place_id 
      survfield.field_name = param.name
      #survfield.lat = param.lat
      #survfield.lng = param.lng
      #survfield.phone_number = param.formatted_phone_number
      #survfield.address = param.vicinity
      #survfield.icon = param.icon
      #survfield.website = param.website
      #survfield.viewport = param.viewport
      #survfield.types = param.types
      #survfield.international_phone_number = param.international_phone_number
      #survfield.formatted_address = param.formatted_address
      #survfield.address_components = param.address_components
      #survfield.street_number = param.street_number
      #survfield.street = param.street
      #survfield.city = param.city
      #survfield.postal_code = param.postal_code
      #survfield.country = param.country
      #survfield.rating = param.rating
      #survfield.price_level = param.price_level
      #survfield.opening_hours = param.opening_hours
      #survfield.url = param.url
      survfield = Survfield.set_accessor(survfield,current_user_id)
      survfields << survfield
    end
    #ソートかく
    survfields
  end
  #GooglePlacesよりspotで取得した情報を格納
  def self.get_GooglePlaces_spot_param(param,current_user_id)
    survfield = Survfield.new
    survfield.place_id = param.place_id 
    survfield.field_name = param.name
    survfield.viewport = param.viewport
    survfield.lat = param.lat
    survfield.lng = param.lng
    survfield.formatted_phone_number = param.formatted_phone_number
    survfield.formatted_address = param.formatted_address
    survfield.website = param.website
    survfield.rating = param.rating
    survfield = Survfield.set_accessor(survfield,current_user_id)
    survfield
  end

  #フィールド情報取得
  def self.get_accessor(place_id,user_id)
    survfield = Survfield.find_by(place_id: place_id)
    survfield = Survfield.set_accessor(survfield,user_id)
    survfield
  end

  #データ格納用
  def self.get_param_survfield(params)
    survfield = Survfield.new
    survfield.place_id = params[:place_id]
    survfield.field_name = params[:field_name]
    survfield.viewport = params[:viewport]
    survfield.lat = params[:lat]
    survfield.lng = params[:lng]
    survfield.formatted_phone_number = params[:formatted_phone_number]
    survfield.formatted_address = params[:formatted_address]
    survfield.website = params[:website]
    survfield.rating = params[:rating]
    survfield
  end

  #アクセサの設定
  #登録されているフィールドと比較し、存在する場合はフラグを立てる。
  #参加済登録されているフィールドと比較し、存在する場合はフラグを立てる。
  def self.set_accessor(survfield,user_id)
    #if survfield.present?
      wented_filed = WentSurvfield.find_by(place_id: survfield[:place_id], user_id: user_id)
      if wented_filed.nil?
        survfield.wented_field_flg = Survfield::NOWENT
      else
        survfield.wented_field_flg = Survfield::WENTED
      end
    #end
    survfield
  end
end
