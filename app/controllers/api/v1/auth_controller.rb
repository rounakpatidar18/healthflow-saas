class Api::V1::AuthController < ApplicationController
  skip_before_action :authorize_request, only: %i[signup login]

  def signup
    user = User.new(user_params)

    if user.save
      token = Auth::JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = Auth::JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :role, :tenant_id)
  end
end
