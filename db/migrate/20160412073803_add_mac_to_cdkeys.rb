class AddMacToCdkeys < ActiveRecord::Migration
  def change
    add_column :cdkeys, :mac, :string
  end
end
