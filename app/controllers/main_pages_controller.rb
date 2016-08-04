class MainPagesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :created_company!, only: [:show]
  def show
    whatday = Date.new(main_params[:year].to_i,main_params[:month].to_i,main_params[:day].to_i)
    line_chart = []
    for i in 0..whatday.wday - 1
      today_statistics(whatday -whatday.wday + i)
      line_chart[i] = [@late_count,@run_count,@absence_count,0] #last 0 is for vacate
    end
    today_statistics(whatday)
    respond_to do |format|
      format.json{ render :json => { come: @come_count, 
                                                      late: @late_count,
                                                      absence: @absence_count,
                                                      run: @run_count,
                                                      total_count: @total_count,
                                                      dayoff: 0,
                                                      percent: @percent,
                                                      total: @total,
                                                      chart: line_chart } }
    end
  end

  def today_statistics(today_is_what_day)
    @come_count = 0
    @late_count = 0
    @absence_count = 0
    @run_count = 0
    @total_count = 0
    @total = 0.0
    now = Time.now.to_a[2] * 60 + Time.now.to_a[1] 
    if calendar = Calendar.find_by(corperation_id:current_user.corperation_id,day:Date.today)
      if calendar.arrive.nil? || calendar.leave.nil?
        times = TimeSet.where(corperation_id:current_user.corperation_id).last      
        spday = false  
      else
        times = calendar
        spday = true
      end
    else
      times = TimeSet.where(corperation_id:current_user.corperation_id).last      
      spday = false
    end
    whatday = today_is_what_day

    Corperation.find(current_user.corperation_id).departments.ids.each do |x|
      @total += Department.find(x).employees.count
    end

    if spday == true
      Corperation.find(current_user.corperation_id).departments.ids.each do |x|
        Department.find(x).employees.ids.each do |y|
          Record.where(date: whatday,employee_id: y).each do |z|
            if now < times.arrive * 60
              if z.status == 'normal'
                @come_count += 1
              end
            elsif now < times.leave * 60
              if z.status == 'normal'
                @come_count += 1              
              elsif z.status == 'late'
                @late_count += 1
              end
            else
              if z.status == 'normal'
                @come_count += 1              
              elsif z.status == 'late'
                @late_count += 1
              end
              @total_count += 1                                          
            end
          end
        end
      end
      if now > times.leave * 60
        @absence_count = @total - @total_count
      end
    else
      Corperation.find(current_user.corperation_id).departments.ids.each do |x|
        Department.find(x).employees.ids.each do |y|
          Record.where(date: whatday,employee_id: y).each do |z|
            if now < times.arrive * 60
              if z.status == 'normal'
                @come_count += 1
              end
            elsif now < times.late * 60
              if z.status == 'normal'
                @come_count += 1
              elsif z.status == 'late'
                @late_count += 1
              end
            elsif now < times.leave * 60
              if z.status == 'normal'
                @come_count += 1
              elsif z.status == 'late'
                @late_count += 1
              elsif z.status == 'absence'
                @absence_count += 1
              end
            elsif now > times.finish * 60
              if z.status == 'normal' && z.pm_status == 'normal'
                @come_count += 1
              elsif z.status == 'late' && z.pm_status == 'normal'
                @late_count += 1
              elsif z.status == 'normal' && z.pm_status == 'flag'
                @run_count += 1
              elsif z.status == 'late' && z.pm_status != 'normal'
                @absence_count += 1
              elsif z.status == 'absence'
                @absence_count += 1
              end
            else
              if z.status == 'normal' && z.pm_status == 'normal'
                @come_count += 1
              elsif z.status == 'late' && z.pm_status == 'normal'
                @late_count += 1
              elsif z.status == 'absence'
                @absence_count += 1
              end
            end
            @total_count += 1       
          end
        end
      end
    end

    if now > times.late * 60
      @absence_count += @total - @total_count
    end
    @percent = @total_count / @total
  end

  private
    def main_params
      params.permit(:year,:month,:day)
    end
end
