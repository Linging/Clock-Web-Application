class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # disable the CSRF token
  skip_before_action :verify_authenticity_token
  before_action :destroy_session
  include SessionsHelper
  include Pundit
  attr_accessor :current_user
  
  def destroy_session
  	request.session_options[:skip] = true
  end
  
  def authenticate_user!
    begin
      token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
      user_mobile = options.blank?? nil : options[:mobile]
      user = User.find_by(mobile: user_mobile)
      if user &&  ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
        self.current_user = user
      else
        return unauthenticated!
      end
    rescue 
      return unauthenticated!
    end
  end

  def unauthenticated!
    api_error(status: 401)
  end

  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end

  def created_company!
    if current_user.corperation_id.nil?
    api_error(status: 403) 
    end
  end
end
