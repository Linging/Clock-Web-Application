class GetMacsController < ApplicationController
  def create
    params.permit!

    @coming = Time.now.to_a[2] * 60 + Time.now.to_a[1]
    find_corperation
    find_employee
    today = Date.today
    create_first_day_record
    if @times = Calendar.find_by(day: today, corperation_id: @id_corperation[0])
      if @times.arrive == nil || @times.leave == nil
        @times = TimeSet.find_by(corperation_id: @id_corperation[0])
        clock_clock
      else
        sp_clock
      end
    else
      @times = TimeSet.find_by(corperation_id: @id_corperation[0])#if there is no setted date before.
      clock_clock   
    end
  end

  def sp_clock
    for i in 0..@ids_employees.length - 1
      if @coming < @times.arrive * 60 - 120
        break
      elsif @coming < @times.arrive * 60
        record_come(@ids_employees[i][0])
      elsif @coming < @times.leave * 60
        record_late(@ids_employees[i][0])
      end
    end
  end

  def clock_clock
    for i in 0..@ids_employees.length - 1
      if @coming < @times.start * 60
        break
      elsif @coming < @times.arrive * 60
        record_come(@ids_employees[i][0])
      elsif @coming < @times.late * 60
        record_late(@ids_employees[i][0])

      elsif @coming < @times.run * 60
        record_absence(@ids_employees[i][0]) 
      elsif @coming < @times.leave * 60
        record_not_absence(@ids_employees[i][0])
      elsif @coming < @times.finish * 60
        record_leave(@ids_employees[i][0])
      else
        record_overtime(@ids_employees[i][0])
      end
    end    
  end

  def find_corperation
    if Corperation.where(mac: params["mac"])
      @id_corperation = Corperation.where(mac: params["mac"]).ids       
    end
  end

  def find_employee
    goodboys = []
    n = 0
    k = 0
    while params[(n+1).to_s]
      mac_address = /\w+:\w+:\w+:\w+:\w+:\w+/.match(params[(n+1).to_s]).to_s
      if Employee.where(mac: mac_address).empty?
        n += 1
      else
        goodboys[k] = Employee.where(mac: mac_address).ids
        n += 1
        k += 1
      end
    end
    @ids_employees = goodboys
  end

  def create_first_day_record
    if @ids_employees.length != 0
      for i in 0..@ids_employees.length - 1
        record = Record.where(employee_id: @ids_employees[i][0])
        if record.empty?
            Record.create(employee_id:@ids_employees[i][0],date:Date.today)
        else
         if record.last.date != Date.today  
            Record.create(employee_id:@ids_employees[i][0],date:Date.today) 
         end
        end
      end
    end
  end

  private

  def record_come(id)
    record = Record.where(employee_id: id,date: Date.today).last
    if record.status.nil?
      record.update(status: "normal")
    end
  end

  def record_late(id)
    record = Record.where(employee_id: id,date: Date.today).last
      if record.status.nil?
        record.update(status: "late")
      end
  end

  def record_absence(id)
    record = Record.where(employee_id: id,date: Date.today).last
      if record.status.nil?
        record.update(status: "absence")
      end
  end

  def record_not_absence(id)
    record = Record.where(employee_id: id,date: Date.today).last
      if record.pm_status.nil?
        record.update(pm_status: "flag")
      end
  end

  def record_leave
    record = Record.where(employee_id: id,date: Date.today).last
    record.update(pm_status: "normal")
  end

end

# Started POST "/get_macs.json" for 192.168.2.1 at 2016-04-14 09:22:07 +0800
# Cannot render console from 192.168.2.1! Allowed networks: 127.0.0.1, ::1, 127.0.0.0/127.255.255.255
# Processing by GetMacsController#create as JSON
  # Parameters: {"mac"=>"00:11:22:33:44:55", 
                       # "1"=>"{\"mac\":\"0e:07:23:2b:14:c2\",\"db\":\"-62\"}", 
                       # "2"=>"{\"mac\":\"0c:84:dc:f7:bf:29\",\"db\":\"-61\"}",  
                       # "3"=>"{\"mac\":\"64:cc:2e:6d:64:3e\",\"db\":\"-67\"}", 
                       # "4"=>"{\"mac\":\"00:27:10:87:5d:04\",\"db\":\"-64\"}", 
                       # "5"=>"{\"mac\":\"24:09:95:21:6c:50\",\"db\":\"-65\"}"}

