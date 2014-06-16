require 'spec_helper'

describe SessionsController, type: :controller do
  describe '#authenticate' do
    context 'when successful' do
      before(:each) do
        AuthenticationToken.should_receive(:generate_token).and_return("authtoken")

        post :authenticate, tenant: { email: 'test@hotmail.com', password: 'password' }
      end

      it 'should return status code of 201' do
        expect(response.status).to eq(201)
      end

      it 'should return json with authentication code' do
        expect(response.body).to eq( { authentication_token: 'authtoken' }.to_json )
      end
    end

    context 'when not successful' do
      before(:each) do
        AuthenticationToken.should_receive(:generate_token).and_return(nil)

        post :authenticate, tenant: { email: 'test@hotmail.com', password: 'password' }
      end

      it 'should return status code of 401' do
        expect(response.status).to eq(401)
      end

      it 'should return json with error message' do
        expect(response.body).to eq( { errors: ['Invalid email address or password'] }.to_json )
      end
    end
  end

  describe '#logout' do
    context 'when authorization failed' do
      it 'should return status code of 401' do
        AuthenticationToken.should_receive(:authorize?).and_return(false)

        delete :logout, authentication_token: { email_address: 'test@hotmail.com', token: 'token' }
        expect(response.status).to eq(401)
      end
    end

    context 'when authorization successful' do
      before(:each) do
        AuthenticationToken.should_receive(:authorize?).and_return(true)
      end

      context 'when delete successful' do
        it 'should return status code of 200' do
          AuthenticationToken.should_receive(:delete_token).and_return(true)

          delete :logout, authentication_token: { email_address: 'a', token: 'b' }
          expect(response.status).to eq(200)
        end
      end

      context 'when delete not successful' do
        it 'should return status code of 400' do
          AuthenticationToken.should_receive(:delete_token).and_return(false)

          delete :logout, authentication_token: { email_address: 'a', token: 'b' }
          expect(response.status).to eq(400)
        end
      end
    end
  end
end
