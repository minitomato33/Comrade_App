class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!, if: :use_auth?

    protected

  def use_auth?
    unless controller_name == 'pagetops' && action_name == 'index'
      true
    end
  end

  def configure_permitted_parameters
    added_attrs = %i[account_name account_id email password password_confirmation sex age experience participation playstyle holiday memo]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit(:account_update, keys: [:image])
  end

  # ログイン後、/indexに移動する
  def after_sign_in_path_for(_resource)
    user_path(current_user.id)
  end
end
