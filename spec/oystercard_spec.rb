require 'oystercard'

describe Oystercard do

  describe '#balance' do
    it { is_expected.to respond_to :balance }
    it 'should have a default balance of 0' do
      expect(subject.balance).to eq (0)
    end
  end

  describe '#top_up' do
    it { expect(subject).to respond_to(:top_up).with(1).argument }
    it 'should add 2 to the balance if top_up is 2' do
      expect{ subject.top_up(2) }.to change { subject.balance }.by 2
    end
    it 'should throw error if goes beyond limit of default' do
      expect { subject.top_up(Oystercard::DEFAULT_LIMIT + 1) }.to raise_error "Top up not possible, limit of #{Oystercard::DEFAULT_LIMIT} reached."
    end
  end

  describe '#deduct' do
    it { expect(subject).to respond_to(:deduct).with(1).argument }
    it 'should deduct balance by 5 if deducted 5' do
      oyster = Oystercard.new(10)
      expect{ oyster.deduct(5) }.to change { oyster.balance }.by (-5)
    end
  end

  describe '#in_journey?' do
    it { expect(subject).to respond_to(:in_journey?) }
    it { expect(subject.in_journey?).to eq false }
  end

  describe '#touch_in' do
    it "should make in_journey return true" do
      expect { subject.touch_in }.to change { subject.in_journey? }.from(false).to (true)
    end
  end

  describe '#touch_out' do
    it "should make in_journey return false" do
      subject.touch_in
      expect { subject.touch_out }.to change { subject.in_journey? }.from(true).to (false)
    end
  end
end
