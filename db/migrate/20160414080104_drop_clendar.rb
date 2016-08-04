class DropClendar < ActiveRecord::Migration
  def up
    drop_table :calendars
  end
end
