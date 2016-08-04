class MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        if @message.seccode_match?    #if the message seccode is correct
          if @token = @message.get_token
              format.json{ render :json =>  @token  }
          else
              format.json{ render :json => { success: true } }
          end
        else
        	  format.json{ render :json => { error:-1 } }
        end
      else
          format.json { render :json => { error: -2} }
      end
    end
  end

  private

    def message_params
      params.permit(:mobile,:seccode)
    end
end
