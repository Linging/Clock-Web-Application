class DropTableEmployee < ActiveRecord::Migration
  def up
    drop_table :employees
  end
end
