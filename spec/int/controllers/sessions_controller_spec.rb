require 'spec_helper'

describe SessionsController, type: :controller do
  describe '#authenticate' do
    context 'when successful' do
      before(:each) do
        tenant = create(:tenant)

        post :authenticate, tenant: { email: tenant.email_address, password: tenant.password }
      end

      it 'should return status code of 201' do
        expect(response.status).to eq(201)
      end

      it 'should return json with authentication code' do
        expect(JSON.parse(response.body)["authentication_token"]).to_not be_empty
      end

      it 'should create authentication token' do
        expect(AuthenticationToken.count).to eq(1)
      end
    end
  end

  describe '#logout' do
    let!(:authentication_token) { create(:authentication_token) }

    context 'when successful' do
      before(:each) do
        delete :logout, authentication_token: { email_address: authentication_token.tenant.email_address, token: authentication_token.token }
      end

      it 'should return status code of 200' do
        expect(response.status).to eq(200)
      end

      it 'should delete authentication token' do
        expect(AuthenticationToken.count).to eq(0)
      end
    end
  end
end