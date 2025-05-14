class JsonWebToken
  SECRET_KEY = ENV["JWT_SECRET_KEY"]

  def self.encode(payload, exp = 12.hours.from_now)
    payload[:exp] = exp.to_i
    pp "token encode ==== #{SECRET_KEY}"
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]

    HashWithIndifferentAccess.new(body)
  end
end
