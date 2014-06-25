require 'spec_helper'

describe TenantsController, type: :controller do
  describe '#register' do
    context 'when successful' do
      it 'should return status code of 200' do
        Tenant.should_receive(:create).and_return(true)

        post :create, tenant: { first_name: 'first name', last_name: 'last_name', email_address: 'email@email.com', password: 'password', password_confirmation: 'password' }

        expect(response.status).to eq(200)
      end
    end

    context 'when not successful' do
      it 'should return status code of 400' do
        Tenant.should_receive(:create).and_return(false)

        post :create, tenant: { first_name: 'first name', last_name: 'last_name', email_address: 'email@email.com', password: 'password', password_confirmation: 'password' }

        expect(response.status).to eq(400)
      end
    end
  end
end
