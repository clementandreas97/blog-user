class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  def user
    # Check if user is in the database
    # memoize the user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # Handling not found user
  rescue ActiveRecord::RecordNotFound => e
    # Raise custom error
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  # Decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # Check for token in `Authorization` header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end

    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
