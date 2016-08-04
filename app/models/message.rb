class Message < ActiveRecord::Base
  validates :mobile, presence:true, length: { maximum:11 }
  validates :seccode, presence:true, length: { maximum:6 }
  def seccode_match?
    if SendMessage.find_by(mobile: self.mobile)
      if self.seccode == SendMessage.where(mobile:self.mobile).last.seccode
         true
      else
         false
      end
    else
      false
    end
  end

  def get_token
    if User.find_by(mobile: self.mobile)
      params = Hash.new
      params['token'] = User.find_by(mobile: self.mobile).reset_digest
      params['id'] = User.find_by(mobile: self.mobile).id
      params
    else
      false
    end 
  end
end
