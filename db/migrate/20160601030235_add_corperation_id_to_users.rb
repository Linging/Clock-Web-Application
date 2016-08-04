class AddCorperationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :corperation_id, :reference
  end
end
