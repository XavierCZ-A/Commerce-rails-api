class Authentication::SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    @user = User.find_by(email_address: params[:email_address])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id, email: @user.email_address)
      user_json = UserBlueprint.render_as_hash(@user)

      render json: { user: user_json, token: token }, status: :ok
    else
      render json: { errors: [ "Invalid email address or password" ] }, status: :unauthorized
    end
  end
end
