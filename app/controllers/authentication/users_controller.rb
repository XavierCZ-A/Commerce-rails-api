class Authentication::UsersController < ApplicationController
  skip_before_action :authenticate

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserBlueprint.render(@user), status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :first_name, :last_name, :email_address, :password ])
  end
end
