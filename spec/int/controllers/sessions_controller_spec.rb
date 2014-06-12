require 'spec_helper'

describe SessionsController, type: :controller do
  describe '#authenticate' do
    context 'when successful' do
      before(:each) do
        tenant = create(:tenant)

        post :authenticate, user: { email: tenant.email_address, password: tenant.password }
      end

      it 'should return status code of 200' do
        expect(response.status).to eq(200)
      end

      it 'should return json with authentication code' do
        expect(JSON.parse(response.body)["authentication_token"]).to_not be_empty
      end
    end
  end
end