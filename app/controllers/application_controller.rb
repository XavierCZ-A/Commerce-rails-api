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
    if header.blank?
      render json: { error: "Token inválido" }, status: :unauthorized and return
    end
    token = header.split(" ").last if header
    decode_token = JsonWebToken.decode(token)
    @current_user = User.find(decode_token[:user_id])
  end

  def current_active_cart
    return nil unless @current_user
    @current_active_cart ||= @current_user.active_cart
  end
end
