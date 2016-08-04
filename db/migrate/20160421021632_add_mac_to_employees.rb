class AddMacToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :mac, :string
  end
end
