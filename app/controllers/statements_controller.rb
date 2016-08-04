class StatementsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    respond_to do |format|
      generate_statement
      if @forms = Statement.find_by(corperation_id: current_user.corperation_id,year: statement_params[:year],month: statement_params[:month])
        format.json{ render :json => { statement: eval(@forms.status),
                                                        year:statement_params[:year],
                                                         month: statement_params[:month]}}
      else        
        format.json{ render :json => { error: "unknown bug"} }
      end
    end
  end

  private
  def generate_statement
    if Statement.find_by(corperation_id: current_user.corperation_id,year: statement_params[:year],month: statement_params[:month]).nil?
      Statement.create(corperation_id: current_user.corperation_id,year: statement_params[:year],month: statement_params[:month])
      write_record
    else
      @table = Statement.find_by(corperation_id: current_user.corperation_id,year: statement_params[:year],month: statement_params[:month])
      if @table.updated_at < 24.hours.ago
        write_record  #update statement
      end
    end
  end

  def write_record
    @statement = Hash.new
    working_days
    Corperation.find(current_user.corperation_id).departments.ids.each do |x|
      Department.find(x).employees.ids.each do |y|
        @attendance_count = 0
        @late_count = 0
        @absence_count = 0
        @run_count = 0
        name = Employee.find(y).name
        Record.where(employee_id:y).each do |z|
          if z.date.month == statement_params[:month].to_i && z.date.year == statement_params[:year].to_i
            if z.status == 'normal' && z.pm_status == 'normal'
              @attendance_count += 1
            elsif z.status == 'late'
              @late_count += 1
            elsif z.status == 'absence'  #+absence+
              @absence_count += 1
            elsif z.status == 'normal' && z.pm_status == 'flag'
              @run_count += 1
            end
          end
        end
        @absence_count += @workingdays - @attendance_count - @late_count - @run_count - @absence_count 
        @statement["#{y}"] = [@attendance_count,@late_count,@absence_count,@run_count,Employee.find(y).department.name,name]
      end
    end
    Statement.find_by(year:statement_params[:year].to_i,month:statement_params[:month].to_i,corperation_id:current_user.corperation_id).update(status:@statement.to_s)
  end

  def working_days
    @workingdays = 0
    weekdays = 0
    selected_month = Date.new(statement_params[:year].to_i,statement_params[:month].to_i)
    if selected_month.month == Date.today.month && selected_month.year == Date.today.year
      for i in 0..Date.today.day - 1
        thatday = Date.today - i
        puts "select 1 tube"
        if thatday.sunday? || thatday.saturday?
          weekdays += 1
        end
        if spday = Calendar.find_by(day:thatday, corperation_id:current_user.corperation_id)
          if spday.dayoff == true && spday.holiday == false
            @workingdays -= 1
          elsif spday.dayoff == false && spday.holiday == true
            @workingdays += 1
          end
        end
      end
      @workingdays = Date.today.day - weekdays + @workingdays
      if @workingdays < 0
        @workingdays = 0
      end
    elsif selected_month < Date.today
      thatday = selected_month
      while thatday.month == selected_month.month
        puts "select 2 tube"
        if thatday.sunday? || thatday.saturday?
          weekdays += 1
        end 

        if spday = Calendar.find_by(day:thatday, corperation_id:current_user.corperation_id)
          if spday.dayoff == true && spday.holiday == false
            @workingdays -= 1
          elsif spday.dayoff == false && spday.holiday == true
            @workingdays += 1
          end
        end    
        thatday += 1   
      end
      @workingdays = (thatday - 1).day - weekdays + @workingdays
    end
  end

  def statement_params
    params.permit(:year,:month)
  end
end
