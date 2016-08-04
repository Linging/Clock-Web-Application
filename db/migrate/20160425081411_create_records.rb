class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :employee, index: true, foreign_key: true
      t.date :date
      t.string :status

      t.timestamps null: false
    end
  end
end
