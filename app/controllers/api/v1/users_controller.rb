class Api::V1::UsersController < ActionController::Base
  def sign_up
    user = User.new(user_params)
    if user.save!
      @token = user.api_tokens.create
      if @token
        @token.update(active: true)
      end

      render json: { message: 'User created successfully', user: user, token: user.api_tokens.first.token }, status: 200
    else
      render json: { errors: 'User Not Created'}, status: :unprocessable_entity
    end
  end

  def sign_in
    user = User.find_by(email: params[:email])
    if user.present? && valid_password?(user)
      token = get_token(user)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def token
    token = ApiToken.find_by(token: params[:token])

    if token.present?
      render json: { status: token.active }, status: :ok
    else
      render json: { error: 'Token not found' }, status: 404
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
    token = user.api_tokens.find_by(active: true).token
  end

  def valid_password?(user)
    user&.valid_password?(params[:password])
  end
end