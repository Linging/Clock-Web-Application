class AddMonthToStatement < ActiveRecord::Migration
  def change
    add_column :statements, :month, :intger
  end
end
