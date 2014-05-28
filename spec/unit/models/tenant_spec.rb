require 'spec_helper'

describe Tenant do
	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email_address) }
	it { should respond_to(:password) }
	it { should respond_to(:salt) }
end
