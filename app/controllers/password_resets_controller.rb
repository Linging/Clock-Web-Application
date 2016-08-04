class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]

  def update
    respond_to do |format|
      if user = User.find_by(mobile: params[:mobile], reset_digest: params[:reset_digest]) 
        if user.update(password_reset_params)
          format.json{ render :json => { success: true } }
        else
          format.json{ render :json => { error: -1 } }        
        end 
      else
        format.json{ render :json => { error: -2 } }        
      end
    end
  end

  private
    def password_reset_params
      params.permit(:mobile,:reset_digest,:password,:password_confirmation)
    end

    def get_user
      @user = User.find_by(mobile: password_reset_params[:mobile])
    end
end
