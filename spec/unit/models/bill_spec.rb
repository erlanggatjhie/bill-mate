require 'spec_helper'

describe Bill do
  it { should respond_to(:description) }
  it { should respond_to(:amount) }
  it { should respond_to(:due_date) }

  it 'should not be valid when description is empty' do
    expect(build(:bill, description: '')).to_not be_valid
  end

  it 'should not be valid when due date is empty' do
    expect(build(:bill, due_date: '')).to_not be_valid
  end

  it 'should not be valid when due date is in the past' do
    expect(build(:bill, due_date: 1.minutes.ago)).to_not be_valid
  end

  it 'should not be valid when amount is equal to or less than 0' do
    expect(build(:bill, amount: 0)).to_not be_valid
    expect(build(:bill, amount: -1)).to_not be_valid
  end

  it 'should not be valid when amount is greater than 99,99,999.99' do
    expect(build(:bill, amount: 10000000000)).to_not be_valid
  end

  it 'should not be valid when amount precision is more than 2 digits' do
    expect(build(:bill, amount: 1.012)).to_not be_valid
  end

  it 'should be valid when correct details given' do
    expect(build(:bill)).to be_valid
  end
end
