require 'spec_helper'

describe Tenant do
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email_address) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }

  it 'should not be valid when first name is empty' do
    expect(build(:tenant, first_name: '')).not_to be_valid
  end

  it 'should not be valid when first name length is greater than 15' do
    expect(build(:tenant, first_name: 'abcdefghijklmnop')).not_to be_valid
  end

  it 'should not be valid when last name is empty' do
    expect(build(:tenant, last_name: '')).not_to be_valid
  end

  it 'should not be valid when last name length is greater than 15' do
    expect(build(:tenant, last_name: 'abcdefghijklmnop')).not_to be_valid
  end

  it 'should not be valid when email is not in valid format' do
    expect(build(:tenant, email_address: 'testtest.com')).not_to be_valid
  end

  it 'should not be valid when password and password confirmation is empty' do
    expect(build(:tenant, password: '', password_confirmation: '')).not_to be_valid
  end

  it 'should not be valid when password is less than 8 characters' do
    expect(build(:tenant, password: '1234567', password_confirmation: '1234567')).not_to be_valid
  end

  it 'should not be valid when password and pasword confirmation are not matched' do
    expect(build(:tenant, password: '123456788', password_confirmation: '123456889')).not_to be_valid
  end

  it 'should be valid when valid fields given' do
    expect(build(:tenant)).to be_valid
  end
end