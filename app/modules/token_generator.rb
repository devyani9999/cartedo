require 'jwt'

module TokenGenerator
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM = 'HS256'

  def generate_token(payload)
    JWT.encode payload, HMAC_SECRET, HMAC_SECRET
  end

  def retrieve_token(token)
    JWT.decode token, HMAC_SECRET, true, { algorithm: HMAC_SECRET }
  end
end