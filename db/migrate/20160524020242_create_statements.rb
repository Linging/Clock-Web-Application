class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.references :corperation, index: true, foreign_key: true
      t.text :status

      t.timestamps null: false
    end
  end
end
