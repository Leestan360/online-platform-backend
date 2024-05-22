class UsersController < ApplicationController
  # Authorize some methods
  before_action :authorize, only: [:profile]

  # User profile
  def profile
      render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end
  
  # Create a new user
  def create
    @user = User.create!(user_params)
    @token = encode_token({ user_id: @user.id })
    render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
  end

  private

  # Params for a user
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
