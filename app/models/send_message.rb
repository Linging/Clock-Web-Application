class SendMessage < ActiveRecord::Base
  after_create :write_in_random

  validates :mobile, presence: true, numericality: true, length: { is:11 }
  # write in table
  def write_in_random
    self.seccode = SendMessage.random
    update_attribute(:created_at, Time.zone.now)
  end
  # twice sending with a interval of 1 minute 
  def seccode_expired?
    created_at < 1.minutes.ago
  end
  #get a random seccode
  def self.random
    code = rand(999999)
    if code != 0
      while code < 100000
        code *= 10
      end
    else
      code = "000000"
    end
    code.to_s
  end

  def xsend
    apikey = '76772a12c77fdf0a5c911f1eba238406'
    send_tpl_sms_uri = URI.parse('https://sms.yunpian.com/v2/sms/tpl_single_send.json')
    params = Hash.new 
    params['apikey'] = apikey
    params['mobile'] = mobile
    params['tpl_id'] = 1299971
    params['tpl_value'] = URI::escape('#code#')+'='+URI::escape(seccode)+'&'+URI::escape('#minutes#')+'='+URI::escape('5')
    response = Net::HTTP.post_form(send_tpl_sms_uri,params)
    print response.body + '\n'
  end

  def resend
    if check_expiration
      xsend
    end
  end

end
