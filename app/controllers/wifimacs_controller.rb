class WifimacsController < ApplicationController
  def new
      if Employee.find_by(mac: params[:mac])
        redirect_to "http://192.168.3.1:80/wfidog/auth?token=123"     
      else
        redirect_to "http://192.168.3.212:8081/crazylark/mobileregister.html?login?gw_id=#{params[:gw_id]}&gw_address=#{params[:gw_address]}&gw_port=#{params[:gw_port]}&mac=#{params[:mac]}&url=#{params[:url]}/"   
      end  
  end

  def ping
      respond_to do |format|
        format.text{ render :text => "pong" }  
      end
  end

  def portal
    redirect_to "http://www.baidu.com"
  end
  
  def auth
    if params[:token] == '123'
      respond_to do |format|
        format.text { render :textr => "Auth: 1" }  
      end
    end
  end
end
