class CreateCdkeys < ActiveRecord::Migration
  def change
    create_table :cdkeys do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
