# app/lib/json_web_token.rb
class JsonWebToken
  # Secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base
  def self.encode(payload, exp=24.hours.from_now)
  end

  def self.decode(token)
  end
end
