class CreateMobileValidates < ActiveRecord::Migration
  def change
    create_table :mobile_validates do |t|

      t.timestamps null: false
    end
  end
end
