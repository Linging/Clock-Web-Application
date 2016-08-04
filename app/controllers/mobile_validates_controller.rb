class MobileValidatesController < ApplicationController
  def create
    @mobilevali = MobileValidate.new(mobile_params)
    respond_to do |format|
      if @mobilevali.save
        #see if mobile user applied has been signed.
        if @mobilevali.signed?
            format.json{ render :json => { error:-2 } }
        else
            format.json{ render :json => { success:true } }
        end    

      else
        format.json{ render :json => { error:-1 } }
      end
    end
  end

  private
    def mobile_params
      params.permit(:mobile)
    end
end
