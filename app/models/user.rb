class User < ActiveRecord::Base
  before_create :generate_authentication_token
  before_create :password_reset_token
  belongs_to :corperation
  
  validates :mobile, presence: true, length: { is: 11 }, numericality: true,
                 uniqueness: true
  validates :password, presence: true, length: { in: 6..16 },on: :update, allow_blank: true
  validates :key, presence: true, length: { is: 16 }, if: :right_key,
                 uniqueness: true
  has_secure_password
	
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                                               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  #login authentiaction
  def generate_authentication_token
    loop do 
      self.authentication_token = SecureRandom.base64(64)
      break if !User.find_by(authentication_token: authentication_token)
    end
  end
  #reset login authtication
  def reset_auth_token!
    generate_authentication_token
    save
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def password_reset_token
    loop do 
      self.reset_digest = SecureRandom.base64(64)
      break if !User.find_by(reset_digest: reset_digest)
    end
  end

  def password_auth_token!
    password_reset_token
    save
  end

  private
    def right_key
      if Cdkey.find_by(key: key)
        true
      else
        false
      end
    end

end
