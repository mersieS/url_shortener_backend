class Api::V1::UsersController < ActionController::Base
  def create
    user = User.new(user_params)
    if user.save!
      user.api_tokens.create
      render json: { message: 'User created successfully', user: user, token: user.api_tokens.first.token }, status: 200
    else
      render json: { errors: 'User Not Created'}, status: :unprocessable_entity
    end
  end

  def get_user_token
    user = User.find_by(email: params[:email])
    if user.present?
      token = get_token(user)

      render json: { token: token}, status: :ok
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end

  def password_confirmation
    user_params[:password] == params[:password_confirmation]
  end

  def get_token(user)
    user.api_tokens.find_by(active: true).token
  end
end