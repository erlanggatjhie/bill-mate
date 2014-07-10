require 'spec_helper'

describe AccomodationsController, type: :controller do
  describe '#create' do
    context 'when successful' do
      let!(:tenant) { create(:tenant) }
      let!(:tenant2) { create(:tenant) }

      before(:each) do
        post :create, accomodation: { address_line: 'address line', city: 'hawthorn', postcode: '3123', state: 'VIC' }, tenants: [tenant.email_address, tenant2.email_address]
      end

      it 'should create accomodation' do
        expect(Accomodation.count).to eq(1)
      end

      it 'should assign accomodation to tenant' do
        tenant.reload
        expect(tenant.accomodation).to eq(Accomodation.first)
      end
    end
  end
end
