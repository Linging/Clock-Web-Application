class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :mobile
      t.string :seccode

      t.timestamps null: false
    end
  end
end
