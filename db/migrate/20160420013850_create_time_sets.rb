class CreateTimeSets < ActiveRecord::Migration
  def change
    create_table :time_sets do |t|
      t.references :corperation, index: true, foreign_key: true
      t.float :start
      t.float :arrive
      t.float :late
      t.float :run
      t.float :leave
      t.float :finish
      t.timestamps null: false
    end
  end
end
