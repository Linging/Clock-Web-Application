class TimeSetsController < ApplicationController
  before_action :authenticate_user!, only: [:update,:show]
  def update
    respond_to do |format|
      if time = TimeSet.find_by(corperation_id:current_user.corperation_id)
        if time.update(timeset_params)
          format.json{ render :json => { success: true } }
        end
      else
          format.json{ render :json => { error: -1 } }
      end      
    end
  end

  def show
    respond_to do |format|
      @time = TimeSet.find_by(corperation_id:current_user.corperation_id)
      format.json{ render :json => @time }
    end
  end

  private
     def timeset_params
       params.permit(:start,:arrive,:late,:run,:leave,:finish)
     end
end
