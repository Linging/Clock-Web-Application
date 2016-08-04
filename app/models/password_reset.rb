class PasswordReset < ActiveRecord::Base
  validates :mobile, presence: true, length: { is:11 }
  validates :reset_token, presence: true, length: { maximum: 32 }
  validates :password, presence: true, length: { in: 6..16 }
end
