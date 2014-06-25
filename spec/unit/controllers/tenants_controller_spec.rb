require 'spec_helper'

describe TenantsController, type: :controller do
  describe '#register' do
    context 'when successful' do
      it 'should return status code of 200' do
        tenant = double(Tenant)
        tenant.stub(:save) { true }

        Tenant.should_receive(:new).and_return(tenant)

        post :create, tenant: { first_name: 'first name', last_name: 'last_name', email_address: 'email@email.com', password: 'password', password_confirmation: 'password' }

        expect(response.status).to eq(200)
      end
    end

    context 'when not successful' do
      before(:each) do
        tenant = double(Tenant)

        tenant.stub(:save) { false }
        tenant.stub_chain(:errors, :messages) { { :password_confirmation=>["can't be blank"], :first_name=>["can't be blank"], :last_name=>["can't be blank"], :email_address=>["is invalid"] } }

        Tenant.should_receive(:new).and_return(tenant)

        post :create, tenant: { first_name: 'first name', last_name: 'last_name', email_address: 'email@email.com', password: 'password', password_confirmation: 'password' }
      end

      it 'should return status code of 400' do
        expect(response.status).to eq(400)
      end

      it 'should return error message as json' do
        expect(response.body).to eq( { errors: { :password_confirmation=>["can't be blank"], :first_name=>["can't be blank"], :last_name=>["can't be blank"], :email_address=>["is invalid"] } }.to_json )
      end
    end
  end
end
