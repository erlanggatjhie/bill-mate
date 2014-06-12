class SessionsController < ApplicationController
  def authenticate
    token = AuthenticationToken.generate_token(params[:user][:email], params[:user][:password])
    if token
      render json: { authentication_token: token }.to_json
    else
      render json: { errors: ['Invalid email address or password'] }, status: 401
    end
  end
end