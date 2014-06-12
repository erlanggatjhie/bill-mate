require 'spec_helper'

describe SessionsController, type: :controller do
  describe '#authenticate' do
    context 'when successful' do
      before(:each) do
        AuthenticationToken.should_receive(:generate_token).and_return("authtoken")

        post :authenticate, user: { email: 'test@hotmail.com', password: 'password' }
      end

      it 'should return status code of 200' do
        expect(response.status).to eq(200)
      end

      it 'should return json with authentication code' do
        expect(response.body).to eq( { authentication_token: 'authtoken' }.to_json )
      end
    end

    context 'when not successful' do
      before(:each) do
        AuthenticationToken.should_receive(:generate_token).and_return(nil)

        post :authenticate, user: { email: 'test@hotmail.com', password: 'password' }
      end

      it 'should return status code of 401' do
        expect(response.status).to eq(401)
      end

      it 'should return json with error message' do
        expect(response.body).to eq( { errors: ['Invalid email address or password'] }.to_json )
      end
    end
  end
end
