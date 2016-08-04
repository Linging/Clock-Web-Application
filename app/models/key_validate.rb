class KeyValidate < ActiveRecord::Base
  validates :key, presence:true, length: { maximum:16 }
  def buy?
    if Cdkey.find_by(key: self.key)
      true
    else
      false
    end
  end 
end
