class ApplicationController < ActionController::API
  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: "No se encontró el recurso" }, status: :not_found
  end

  rescue_from JWT::DecodeError do |e|
    render json: { error: "Token inválido" }, status: :unauthorized
  end

  rescue_from JWT::ExpiredSignature do |e|
    render json: { error: "Token expirado" }, status: :unauthorized
  end

  private

  def authenticate
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decode_token = JsonWebToken.decode(token)
    @current_user = User.find(decode_token[:user_id])
  end
end
