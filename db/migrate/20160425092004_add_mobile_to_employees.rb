class AddMobileToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :mobile, :string
  end
end
