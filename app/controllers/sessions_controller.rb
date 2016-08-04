class SessionsController < ApplicationController

  def create
    @user = User.find_by(mobile: create_params[:mobile])
    if @user && @user.authenticate(create_params[:password])
      self.current_user = @user
      respond_to do |format|
        format.json{ render :json => { mobile:@user.mobile, 
                                                        token:@user.authentication_token } }
      end	
    else
      return api_error(status: 401)
    end
  end

  def destroy
  	log_out
  end

  private
    def create_params
      params.require(:user).permit(:mobile, :password)
    end
end
