class AddArriveToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :arrive, :float
  end
end
