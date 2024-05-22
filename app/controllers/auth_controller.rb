class AuthController < ApplicationController
  
  # Login in method
  def create
    @user = User.find_by(email: user_login_params[:email])
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: token, message: "Logged in successfuly" }, status: :accepted
    else
      render json: { message: 'Invalid email or password' }, status: :bad_request
    end
  end

  private

  # Login params
  def user_login_params
    params.require(:user).permit(:email, :password)
  end
end
