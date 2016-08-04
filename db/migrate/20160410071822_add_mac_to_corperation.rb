class AddMacToCorperation < ActiveRecord::Migration
  def change
    add_column :corperations, :mac, :string
  end
end
