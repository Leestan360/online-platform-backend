class ApplicationController < ActionController::API

  # Rescue record invalid
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # Rescue record not found
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # Token
  def encode_token(payload, exp: 60.minutes.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, 'my_s3cr3t')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return nil unless auth_header
  
    token = auth_header.split(' ')[1]
    JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
  rescue JWT::DecodeError
    nil
  end  

  # Get current user
  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  # Authorize the user
  def authorize
    render json: { message: "Please sign in!" }, status: :unauthorized unless logged_in?
  end
  
  private

  # Render invalid exception
  def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  # Render not found
  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
