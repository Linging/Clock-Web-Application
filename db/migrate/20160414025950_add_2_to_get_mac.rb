class Add2ToGetMac < ActiveRecord::Migration
  def change
    add_column :get_macs, :"2", :hash
  end
end
