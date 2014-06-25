class TenantsController < ApplicationController
  def create
    if Tenant.create(tenant_params)
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end
end