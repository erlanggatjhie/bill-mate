require 'spec_helper'

describe Accomodation do
  it { should respond_to(:address_line) }
  it { should respond_to(:city) }
  it { should respond_to(:postcode) }
  it { should respond_to(:state) }

  it 'should not be valid when address is empty' do
    expect(build(:accomodation, address_line: '')).to_not be_valid
  end

  it 'should not be valid when city is empty' do
    expect(build(:accomodation, city: '')).to_not be_valid
  end

  it 'should not be valid when postcode format is wrong' do
    expect(build(:accomodation, postcode: 'x0142')).to_not be_valid
  end

  describe 'state' do
    it 'should be valid for VIC' do
      expect(build(:accomodation, state: 'VIC')).to be_valid
    end

    it 'should be valid for NSW' do
      expect(build(:accomodation, state: 'NSW')).to be_valid
    end

    it 'should be valid for ACT' do
      expect(build(:accomodation, state: 'ACT')).to be_valid
    end

    it 'should be valid for QLD' do
      expect(build(:accomodation, state: 'QLD')).to be_valid
    end

    it 'should be valid for SA' do
      expect(build(:accomodation, state: 'SA')).to be_valid
    end

    it 'should be valid for WA' do
      expect(build(:accomodation, state: 'WA')).to be_valid
    end

    it 'should be valid for TAS' do
      expect(build(:accomodation, state: 'TAS')).to be_valid
    end

    it 'should be valid for NT' do
      expect(build(:accomodation, state: 'NT')).to be_valid
    end

    it 'should not be valid for unknown state' do
      expect(build(:accomodation, state: 'LOL')).to_not be_valid
    end
  end

  it 'should be valid when valid details' do
    expect(build(:accomodation)).to be_valid
  end
end
