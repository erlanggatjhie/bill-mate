class SessionsController < ApplicationController
  before_action :authorize, only: [:logout]

  def authenticate
    token = AuthenticationToken.generate_token(params[:tenant][:email], params[:tenant][:password])
    if token
      render json: { authentication_token: token }.to_json, status: 201
    else
      render json: { errors: ['Invalid email address or password'] }, status: 401
    end
  end

  def logout
    if AuthenticationToken.delete_token(params[:authentication_token][:email_address], params[:authentication_token][:token])
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end
end