class WentSurvfield < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :survfield, primary_key: 'place_id', foreign_key: 'place_id' 


  def self.get_accessor(user_id)
    went_survfields = []
    went_infos = WentSurvfield.where(user_id: user_id)    
    went_infos.each do |went_info|
      went_survfield = Survfield.get_accessor(went_info.place_id,user_id)
      went_survfields << went_survfield
    end
    went_survfields
  end
end
