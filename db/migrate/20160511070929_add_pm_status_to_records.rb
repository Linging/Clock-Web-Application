class AddPmStatusToRecords < ActiveRecord::Migration
  def change
    add_column :records, :pm_status, :string
  end
end
