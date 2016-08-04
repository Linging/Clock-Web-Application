class CreateKeyValidates < ActiveRecord::Migration
  def change
     create_table :key_validates do |t|

      t.timestamps null: false
    end
  end
end
