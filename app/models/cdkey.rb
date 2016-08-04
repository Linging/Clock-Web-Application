class Cdkey < ActiveRecord::Base
  
  def key_initialize(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    str = ""
    1.upto(len) { |n| str << chars[rand(chars.size-1)] }
    str
  end

  def key_initialization
    loop do 
      self.key = key_initialization(16)
      break if !Cdkey.find_by(key: key)
    end
  end
end
  #use the code in your console.
  #and these keys below are for admin. 

# <Cdkey id: 7, key: "EkcMhPCBpYEbiUGv">
#<Cdkey id: 8, key: "ngUNVhnq4KCUmJKE">
#<Cdkey id: 9, key: "Jsk8g6CDsfyn0xVL">
#<Cdkey id: 10, key: "iyhwZ318GfERh2C4">
#<Cdkey id: 11, key: "uDNj1vwX6kQfXZZq">
#<Cdkey id: 12, key: "8eUR5rmgbvqlzoBN">
#<Cdkey id: 13, key: "usAWTUuUWsT7sovb">
#<Cdkey id: 14, key: "DSNjgptzoXhNcmNB">
#<Cdkey id: 16, key: "dcGnkig71oRz5E7A">
