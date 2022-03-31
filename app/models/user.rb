class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # アソシエーション
  has_many :follows, foreign_key: 'user_id'
  has_many :wentsurvfields, class_name: 'WentSurvfield', foreign_key: 'user_id'
  has_many :followregularmeetings, class_name: 'FollowRegularmeeting', foreign_key: 'user_id'
  has_many :survfields, through: :WentSurvfield
  has_many :regularmeetings, through: :followregularmeeting
  
  mount_uploader :image, ImageUploader

  # アクセサー
  attr_accessor :is_current_user_following, :followings_count, :followers_count, :user_meeting_status, :similarscore 

  #enum記載
  enum age:{"10代":0,"20代":1,"30代":2,"40代":3,"50代":4,"60代以上":5}
  enum sex:{"男性":0,"女性":1,"その他":2}
  enum experience:{"初心者":0,"１〜３年":1,"４〜６年以内":2,"７〜１０年以内":3,"１１年以上":4}
  enum participation:{"週に2回以上":0,"週に１回程度":1,"月に１〜２回程度":2,"年に数回程度":3}
  enum playstyle:{"本格派":0,"カジュアル派":1,"特になし":2}
  enum holiday:{"土日休み":0,"平日休み":1,"不定休":2}

  # [概　要] ユーザ情報を取得
  # [引　数] 対象のユーザID
  # [戻り値] Userオブジェクト
  # [説　明] 引数で指定されたユーザIDのユーザ情報を返す
  def self.get_user_info(user_id, current_user_id)
    user = User.find_by(id: user_id)
    set_accessor(user,current_user_id)
  end
  
  # [概　要] Userオブジェクトのaccessorに値を代入する
  # [引　数] 対象のユーザID、ログイン中ユーザID
  # [戻り値] Userオブジェクト
  # [説　明] Userオブジェクトのaccesor（フォロー情報）に値をセットする
  def self.set_accessor(user_info,current_user_id) 
    follow = Follow.find_by(user_id:current_user_id, follow_id: user_info.id )

    user_info.is_current_user_following = if user_info.id == current_user_id
                                            Follow::FOLLOW_STATUS_TYPE_MYSELF
                                          elsif follow.nil?
                                            Follow::FOLLOW_STATUS_TYPE_NON_FOLLOWING
                                          else
                                            follow.follow_status
                                          end
    user_info.followings_count = Follow.where(user_id: user_info, follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING).count
    user_info.followers_count = Follow.where(follow_id: user_info, follow_status: Follow::FOLLOW_STATUS_TYPE_FOLLOWING).count
    user_info
  end
  # [概　要] パスワード入力無でユーザ情報更新を行う。本メソッドはDeviseクラスのメソッドのオーバライド。
  # [説　明] パスワード入力無でユーザ情報更新を行う。
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
  # [概　要] 該当の定例会ごとにユーザのミーティングステータスを設定
  def self.set_meetingstatus_accessor(user,followRegularmeeting)
    user.user_meeting_status = followRegularmeeting[:meeting_status]
    user
  end

  # [概　要] 類似ユーザの取得処理
  def self.get_similar_user(current_user_id) 
    similar_user = []
    #ログインユーザ情報
    current_user = User.find(current_user_id)
    #ユーザ全体の情報
    users = User.where.not(id: current_user.id)
    #類似スコアセット処理（戻り値は類似スコアの降順）
    users = User.set_similar_score(users,current_user)
    if users.any? 
      #類似ユーザ上位３人を抜粋
      #類似ユーザ表示最低値40に満たない場合は３人未満でも取得終了
      users.each_with_index do |user,i|
        break if i == 3
        if 40 > user.similarscore
          break
        else
          similar_user << user 
        end
      end
      similar_user
    end
    

  end
  # [概　要] 類似ユーザの処理
  def self.set_similar_score(users,current_user) 
    if users.any? 
      users.each do |user|
        user.similarscore = 0
        if current_user[:age] == user[:age]
          user.similarscore += 10
        end
        if current_user[:sex] == user[:sex]
          user.similarscore += 10
        end
        if current_user[:experience] == user[:experience]
          user.similarscore += 20
        end
        if current_user[:participation] == user[:participation]
          user.similarscore += 20
        end
        if current_user[:playstyle] == user[:playstyle]
          user.similarscore += 10
        end
        if current_user[:holiday] == user[:holiday]
          user.similarscore += 20
        end
        current_user_fields = WentSurvfield.where(user_id: current_user[:id])

        #参加フィールド情報の比較処理
        fieldscount = 0
        if current_user_fields.any?
          current_user_fields.each do |current_user_field|
            user_fields = WentSurvfield.where(user_id: user[:id])
            if user_fields.any?
              user_fields.each do |user_field|
                if current_user_field == user_field
                  fieldscount += 1
                end
              end
            end
          end
        end
        if 1 == fieldscount
          user.similarscore += 20
        elsif 1 < fieldscount
          user.similarscore += 30
        end
      end
      #類似スコアで降順ソート
      users.sort_by { |u| u.similarscore }.reverse
    end
  end
end
