class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.json{ render :json => { success: true } }
      end
    else
      respond_to do |format|
        format.json{ render :json => { error:-1 } }
      end  
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.json{ render :json => @user }
    end
  end

  def index
    @users = User.all
    respond_to do |format|
      format.json{ render :json => @users }
    end
  end

  private

  def user_params
    params.permit(:mobile, :password, :key,:message,
                                          :password_confirmation)
  end
  
end
