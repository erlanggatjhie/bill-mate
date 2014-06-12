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

      it 'should generate token' do
        expect(token).to be_nil
      end
    end
  end
end