class AddYearToStatement < ActiveRecord::Migration
  def change
    add_column :statements, :year, :intger
  end
end
