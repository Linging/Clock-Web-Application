class AddLeaveToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :leave, :float
  end
end
