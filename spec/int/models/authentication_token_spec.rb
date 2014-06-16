require 'spec_helper'

describe AuthenticationToken do
  describe '.generate_token' do
    context 'when authentication successful' do
      let!(:tenant) { create(:tenant) }
      let!(:token) { AuthenticationToken.generate_token(tenant.email_address, tenant.password) }

      it 'should create authentication token' do
        expect(AuthenticationToken.count).to eq(1)
      end

      it 'should generate token' do
        expect(token).to_not be_empty
      end
    end

    context 'when authentication not successful' do
      let!(:token) { AuthenticationToken.generate_token('email', 'randompass') }

      it 'should not create authentication token' do
        expect(AuthenticationToken.count).to eq(0)
      end

      it 'should not generate token' do
        expect(token).to be_nil
      end
    end
  end

  describe '.authorize?' do
    context 'when valid credentials given' do
      it 'should return true' do
        authentication_token = create(:authentication_token)

        expect(AuthenticationToken.authorize?(authentication_token.tenant.email_address, authentication_token.token)).to be_true
      end
    end

    context 'when invalid credentials given' do
      it 'should return false' do
        authentication_token = create(:authentication_token)

        expect(AuthenticationToken.authorize?('random_email_address', authentication_token.token)).to be_false
      end
    end

    context 'when authentication already expired' do
      it 'should return false' do
        authentication_token = create(:authentication_token, expires_in: 3600)

        Timecop.travel(Time.now + 1.hours) do
          expect(AuthenticationToken.authorize?(authentication_token.tenant.email_address, authentication_token.token)).to be_false
        end
      end
    end
  end

  describe '.delete_token' do
    context 'when successful' do
      let!(:authentication_token) { create(:authentication_token) }

      it 'should return true' do
        expect(AuthenticationToken.delete_token(authentication_token.tenant.email_address, authentication_token.token)).to be_true
      end

      it 'should delete token from database' do
        expect { AuthenticationToken.delete_token(authentication_token.tenant.email_address, authentication_token.token) }.to change(AuthenticationToken, :count).to(0)
      end
    end

    context 'when not successful' do
      it 'should return false' do
        expect(AuthenticationToken.delete_token('a', 'token')).to be_false
      end
    end
  end
end