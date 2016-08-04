class KeyValidatesController < ApplicationController
  def create
    @keyvali = KeyValidate.new(keyvali_params)
    respond_to do |format|
      if @keyvali.save
        if @keyvali.buy?
          format.json{ render :json => { success: true } }
        else
          format.json{ render :json => { error:-1 } }
        end
      else
          format.json { render :json => { error:-2 } }
      end
    end
  end

  private
    def keyvali_params
      params.permit(:key)
    end
end
