module Authorization
  def authorizes
    render json: { error: 'Not Authorized' }, status: :unauthorized unless logged_in_user
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token('userId')
      @current_user = User.find(user_id)
    end
  end

  def decoded_token
    if request.headers['Authorization']
      token = request.headers['Authorization'].split('')[1]
      begin
        JsonWebToken.decode(token)
      rescue JsonWebToken::DecodeError
        nil
      end
    end
  end
end