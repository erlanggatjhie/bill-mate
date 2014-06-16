require 'spec_helper'

describe AuthenticationToken do
  it { should respond_to(:token) }
  it { should respond_to(:tenant) }
  it { should respond_to(:expires_in) }

  it 'should not be valid when token is empty' do
    expect(build(:authentication_token, token: '')).to_not be_valid
  end

  it 'should not be valid when token is not unique' do
    create(:authentication_token)
    expect(build(:authentication_token)).to_not be_valid
  end

  it 'should not be valid when tenant is nil' do
    expect(build(:authentication_token, tenant: nil)).to_not be_valid
  end

  it 'should not be valid when expires in is empty' do
    expect(build(:authentication_token, expires_in: nil)).to_not be_valid
  end

  it 'should not be valid when expires in is less than 0' do
    expect(build(:authentication_token, expires_in: -1)).to_not be_valid
  end

  it 'should be valid when valid input given' do
    expect(build(:authentication_token)).to be_valid
  end

  describe '#expired?' do
    it 'should return true when expired' do
      time = Time.now
      authentication_token = build(:authentication_token, expires_in: 3600, created_at: time)

      Timecop.travel(time + 1.hours) do
        expect(authentication_token).to be_expired
      end
    end

    it 'should return false when not expired' do
      time = Time.now
      authentication_token = build(:authentication_token, expires_in: 3600, created_at: time)

      Timecop.travel(time + 59.minutes) do
        expect(authentication_token).to_not be_expired
      end
    end
  end
end
