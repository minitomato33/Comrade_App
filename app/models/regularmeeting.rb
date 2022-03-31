class Regularmeeting < ApplicationRecord
   #アソシエーション
   has_many :users, class_name: 'User', through: :FollowRegularmeeting
   has_many :followregularmeetings, class_name: 'FollowRegularmeeting', foreign_key: 'meeting_id' ,dependent: :destroy
   belongs_to :survfield, primary_key: 'place_id', foreign_key: 'place_id' 

   #アクセッサ
   attr_accessor :meeting_field_name, :planned_regularmeeting_flg, :expired_flg, :regularmeeting_status, :request_flg

  #定例会情報のゲッター設定
	def self.get_accessor(params,user_id)
		regularmeetings = []
		if params.length > 0
			params.each do |regularmeeting|
				regularmeetings << Regularmeeting.set_accessor(regularmeeting,user_id)
			end
		end
		regularmeetings
	end

	#企画定例会情報のセッター設定
	def self.set_accessor(regularmeeting,user_id)
		regularmeeting.meeting_field_name = regularmeeting.survfield.field_name
		if regularmeeting[:user_id] == user_id
			regularmeeting.planned_regularmeeting_flg = true
			regularmeeting.regularmeeting_status = -1
			#申請があるか判定する
			if FollowRegularmeeting.where(meeting_id: regularmeeting[:id],meeting_status: 1).present?
				regularmeeting.request_flg = true
			else
				regularmeeting.request_flg = false
			end
		else
			regularmeeting.planned_regularmeeting_flg = false
			follow_status = FollowRegularmeeting.get_follow_status(regularmeeting[:id],user_id)
			regularmeeting.regularmeeting_status =  if follow_status == 0
																								0
																							else
																								follow_status
			                                        end
		end
		regularmeeting.expired_flg =  if regularmeeting[:participation_day].to_date > Date.today
																		false
																	else
																		true
		                              end
		regularmeeting
	end

	#期限内（有効）だけにフィルター
	def self.get_valid_accessor(params)
		regularmeetings = []
		params.each do |regularmeeting|
			unless regularmeeting[:expired_flg]
				regularmeetings << regularmeeting
			end
		end
		regularmeetings
	end
end
