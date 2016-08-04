class DepartmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create,:update,:show,:destroy]
  def create
    @department = Department.new(name:department_params[:name],corperation_id: current_user.corperation_id)
    respond_to do |format|
      if @department.save
        format.json{ render :json =>  { department: @department } }
      else
        format.json{ render :json => { error: -1 } }
      end
    end
  end

  def update
    department = Department.find(params[:id])
    respond_to do |format|
      if department.update(department_params)
        format.json{ render :json => { success: true } }
      else
        format.json{ render :json => { error: -1 } }     
      end
    end
  end

  def index
    params = Hash.new
    Corperation.all.each do |c|
      c.departments.each do |d|
        params['name'] = c.name.to_s + d.name.to_s
      end
    end
    @department = params
    # @department.quantity
    respond_to do |format|  
      format.json{ render :json => { departments: @departments } }
    end
  end

  def show
    @department = Department.find_by(department_params)
    @employees = @department.employees
    # @department.quantity
    respond_to do |format|
      format.json{ render :json => @employees  }
    end
  end

  def quantity
    respond_to do |format|
      format.json{ render :json =>  self.employees.count  }
    end
  end

  def destroy
    Department.find(params[:id]).destroy
    respond_to do |format|
      format.json{ render :json => { success: true } }
    end    
  end

  private
    def department_params
      params.permit(:name,:id)
    end
end
