class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :day
      t.boolean :dayoff
      t.boolean :holiday
      t.references :corperation

      t.timestamps null: false
    end
  end
end
