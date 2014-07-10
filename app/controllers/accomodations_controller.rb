class AccomodationsController < ApplicationController
  def create
    accomodation = Accomodation.new(accomodation_params)
    accomodation.tenants = Tenant.where(email_address: params[:tenants])

    if accomodation.save
      render nothing: true, status: 201
    else
      render json: { errors: accomodation.errors.messages }, status: 400
    end
  end

  private
  def accomodation_params
    params.require(:accomodation).permit(:address_line, :city, :state, :postcode)
  end
end
