require 'spec_helper'

describe AccomodationsController, type: :controller do
  describe '#create' do
    context 'when successful' do
      it 'should response with status code of 201' do
        mock_tenant = double(Tenant)
        mock_accomodation = double(Accomodation)

        Tenant.stub(:where).and_return([mock_tenant])
        Accomodation.stub(:new).and_return(mock_accomodation)
        mock_accomodation.stub(:tenants=)
        mock_accomodation.stub(:save).and_return(true)

        post :create, accomodation: { address_line: 'address line', city: 'hawthorn', postcode: '3123', state: 'VIC' }, tenants: ['test@test.com']

        expect(response.status).to eq(201)
      end
    end

    context 'when not successful' do
      before(:each) do
        mock_tenant = double(Tenant)
        mock_accomodation = double(Accomodation)

        Tenant.stub(:where).and_return([mock_tenant])
        Accomodation.stub(:new).and_return(mock_accomodation)
        mock_accomodation.stub(:tenants=)
        mock_accomodation.stub(:save).and_return(false)

        mock_accomodation.stub_chain(:errors, :messages) { { address_line: ["can't be blank"], city: ["can't be blank"] } }

        post :create, accomodation: { address_line: 'address line', city: 'hawthorn', postcode: '3123', state: 'VIC' }, tenants: ['test@test.com']
      end

      it 'should response with status code of 400' do
        expect(response.status).to eq(400)
      end

      it 'should have errors in response body' do
        expect(response.body).to eq( { errors: { address_line: ["can't be blank"], city: ["can't be blank"] } }.to_json )
      end
    end
  end
end
