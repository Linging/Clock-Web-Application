class SendMessagesController < ApplicationController
require 'net/http'
require 'uri'

#get post and create ,then post message api
  def create
    @note = SendMessage.new(send_message_param)
    if @note.save
      respond_to do |format|
        format.json{ render :json => { success: true } }	
      end
      @note.xsend
      #accept api error.
    else
      respond_to do |error|
        error.json{ render :json => { error: -1 } }
      end
  end
end

  private
    def send_message_param
      params.permit(:mobile)
    end
end

