module Authenticable
  extend ActiveSupport::Concern
  include ExceptionHandler
  
  class BadToken < StandardError
  end
  
  def token
    params[:token] || params[:auth_token] || token_from_request_headers || cookies.signed[:token]
  end
  
  def token_from_request_headers
    unless request.headers['Authorization'].nil?
      request.headers['Authorization'].split.last
    end
  end
  
  def require_token
    if token.present? && token === Rails.application.credentials.dig(:api, :token)
    else
      raise Authenticable::BadToken.new
    end
  end
end