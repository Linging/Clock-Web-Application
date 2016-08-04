require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(mobile: "15908155455",
				 message: "123456",
				 password: "123456",
				 password_confirmation: "123456")
	end

	test "should be valid" do 
		assert @user.valid?
	end

	test "should be present" do
		@user.mobile = "    "
		assert_not @user.valid?
	end

	test "mobile should be 11bit" do 
		@user.mobile = "12345789789123"
		assert_not @user.valid?
	end

	test "mobile should be with only integers" do
		@user.mobile = "a1234578"
		assert_not @user.valid?
	end

	test "mobile should be unique" do
		duplicate_user = @user.dup 
		@user.save
		assert_not duplicate_user.valid?
	end
end	
