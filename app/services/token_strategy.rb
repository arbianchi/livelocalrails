class TokenStrategy < Devise::Strategies::Base
  def valid?
    request.env["HTTP_AUTHORIZATION"].present?
  end

  def authenticate!
    token = request.env["HTTP_AUTHORIZATION"]
    if user = User.with_token(token)
      success! user
    else
      fail! "No user matches that token"
    end
  end
end
