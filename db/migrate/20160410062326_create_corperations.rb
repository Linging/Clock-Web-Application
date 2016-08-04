class CreateCorperations < ActiveRecord::Migration
  def change
    create_table :corperations do |t|

      t.timestamps null: false
    end
  end
end
