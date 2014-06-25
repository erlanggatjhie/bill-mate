require 'spec_helper'

describe TenantsController, type: :controller do
  describe '#create' do
    context 'when successful' do
      it 'should create tenant' do
        post :create, tenant: { first_name: 'first name', last_name: 'last_name', email_address: 'email@email.com', password: 'password', password_confirmation: 'password' }

        expect(Tenant.count).to eq(1)
      end
    end

    context 'when password and password confirmation mismatch' do
      it 'should not create tenant' do
        post :create, tenant: { first_name: 'first name', last_name: 'last_name', email_address: 'email@email.com', password: 'password', password_confirmation: 'passwordx' }

        expect(Tenant.count).to eq(0)
      end
    end
  end
end