require 'openssl'
require 'base64'

module Duo
  
  # Sign a Duo request with skey, ikey, and the local username
  def sign_request(skey, ikey, username)
    exp = Time.now.to_i + 300

    val = [username, ikey, exp].join('|')
    
    b64 = Base64.encode64(val).strip
    cookie = "TX|#{b64}"

    sig = hmac_sha1(skey, cookie)

    [cookie, sig].join('|')
  end

  # Check a response from Duo with the skey.
  def verify_response(skey, sig_response)
    ts = Time.now.to_i
    u_prefix, u_b64, u_sig = sig_response.to_s.split('|')
    
    sig = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'),
      skey, [u_prefix, u_b64].join('|'))
      
    return nil if hmac_sha1(skey, sig) != hmac_sha1(skey, u_sig)
    
    return nil if u_prefix != 'AUTH'
    
    user, ikey, exp = Base64.decode64(u_b64).to_s.split('|')
    
    return nil if ts >= exp.to_i
    
    return user
  end
  
  private
  def hmac_sha1(key, data)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), key, data.to_s)
  end
  
  extend self
end
