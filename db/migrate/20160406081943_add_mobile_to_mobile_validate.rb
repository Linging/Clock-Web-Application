class AddMobileToMobileValidate < ActiveRecord::Migration
  def change
    add_column :mobile_validates, :mobile, :string
  end
end
