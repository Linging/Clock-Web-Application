class DropGetMacs < ActiveRecord::Migration
  def up
    drop_table :get_macs
  end
end
