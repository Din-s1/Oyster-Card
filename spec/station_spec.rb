require 'station.rb'

describe Station do

  subject { described_class.new('Old Street', 2)}

  it 'should know its name' do
    expect(subject.name).to eq 'Old Street'
  end

  it 'should know its zone' do
    expect(subject.zone).to eq 2
  end

end
