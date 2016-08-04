class AddNameToCorperation < ActiveRecord::Migration
  def change
    add_column :corperations, :name, :string
  end
end
