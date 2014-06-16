class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize
    render nothing: true, status: 401 unless AuthenticationToken.authorize?(params[:authentication_token][:email_address], params[:authentication_token][:token])
  end
end
