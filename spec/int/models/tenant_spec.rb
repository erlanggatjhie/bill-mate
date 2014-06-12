require 'spec_helper'

describe Tenant do
  context 'authenticate' do
    before(:each) do
      @tenant = create(:tenant)
    end

    it 'should return tenant when correct password given' do
      expect(Tenant.authenticate(@tenant.email_address, @tenant.password)).to eq(@tenant)
    end

    it 'should return false when incorrect password given' do
      expect(Tenant.authenticate(@tenant.email_address, @tenant.password + 'stuff')).to be_false
    end
  end
end