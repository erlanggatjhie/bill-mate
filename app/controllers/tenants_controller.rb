class TenantsController < ApplicationController
  def create
    tenant = Tenant.new(tenant_params)

    if tenant.save
      render nothing: true, status: 200
    else
      render json: { errors: tenant.errors.messages }, status: 400
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end
end