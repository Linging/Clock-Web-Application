class MobileValidate < ActiveRecord::Base
  validates :mobile, presence:true, length: { maximum:11 }
  def signed?
    if User.find_by(mobile: self.mobile)
      true
    else
      false
    end
  end
end
