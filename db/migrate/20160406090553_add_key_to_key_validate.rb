class AddKeyToKeyValidate < ActiveRecord::Migration
  def change
    add_column :key_validates, :key, :string
  end
end
