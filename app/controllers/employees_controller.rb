class EmployeesController < ApplicationController
  before_action :authenticate_user!, only: [:index,:update,:destroy]
  def new
    @corperation = Corperaton.find_by(:mac, params[:mac])
    @departments = corperation.departments
    respond_to do |format|
    	format.json{ render :json => @departments }
    end
  end

  def create
    @employee = Employee.new(employee_param)
    respond_to do |format|
      if @employee.save
        format.json{ render :json => { success: true } }
      else
        format.json{ render :json => { error: -1 } }
      end
    end
  end

  def index
    @employees = Employee.all 
    respond_to do |format|
      format.json{ render :json => @employees  }
    end
  end

  def show
    @employee = Employee.find(params[:id])
    @department_name = Department.find(@employee.department_id).name
    employee_record
    respond_to do |format|
  	  format.json{ render :json => { info: @employee,
                                                               department_name: @department_name,
                                                               records: @arr } }
    end
  end

  def update
    employee = Employee.find_by(id:params[:id])
    respond_to do |format|
      if employee.update(employee_param)
        format.json{ render :json => employee }
      else
        format.json{ render :json => { error: -1 } }
      end
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    respond_to do |format|
      format.json{ render :json => { success: true } }
    end
  end

  private
    def  employee_param
      params.permit(:id, :mobile, :name, :mac, :department_id,:year,:month)
    end

    def employee_record
      @arr = []
      i = 0
      first_day = Date.new(params[:year].to_i,params[:month].to_i)
      while first_day.month == params[:month].to_i
        if dday = Calendar.find_by(corperation_id:current_user.corperation_id,day:first_day)
          if dday.dayoff == true
            @arr[i] = [first_day,'normal']
          else #dayoff == false
            if z = Record.find_by(employee_id:params[:id],date:first_day)
              if z.status == 'normal' && z.pm_status == 'normal'
                @arr[i] = [z.date,'normal']
              elsif z.status == 'late'
                @arr[i] = [z.date,'late']
              elsif z.status == 'absence'  #+absence+
                @arr[i] = [z.date,'absence']
              elsif z.status == 'normal' && z.pm_status != 'normal'
                @arr[i] = [z.date,'run']
              end
            else
              @arr[i] = [z.date,'absence']
            end
          end
        elsif first_day.sunday? || first_day.saturday?
          @arr[i] = [first_day,'normal']
        elsif z = Record.find_by(employee_id:params[:id],date:first_day)
          if z.status == 'normal' && z.pm_status == 'normal'
            @arr[i] = [z.date,'normal']
          elsif z.status == 'late'
            @arr[i] = [z.date,'late']
          elsif z.status == 'absence'  
            @arr[i] = [z.date,'absence']
          elsif z.status == 'normal' && z.pm_status != 'normal'
            @arr[i] = [z.date,'run']
          end
        else
          @arr[i] = [first_day,'absence']
        end
        first_day += 1
        i += 1
      end
    end 

end
