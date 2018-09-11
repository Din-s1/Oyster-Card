require 'oystercard'

describe Oystercard do

  before(:each) {
    @oyster = Oystercard.new(Oystercard::LOWER_LIMIT)
  }

  let(:station) {double("station")}
  let(:exit_station) {double("exit station")}
  let(:touch_in) { @oyster.touch_in(station) }
  let(:touch_out) { @oyster.touch_out(exit_station) }

  describe 'journeys' do
    it { is_expected.to respond_to :journeys }
    it 'should be empty as default' do
      expect(subject.journeys).to be_empty
    end
    it 'touch in and out creates only one journey' do
      touch_in
      touch_out
      expect(@oyster.journeys.size).to eq 1
    end
  end

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

  describe '#in_journey?' do
    it { expect(subject).to respond_to(:in_journey?) }
    it { expect(subject).to_not be_in_journey }
  end

  describe '#touch_in' do
    it "should make in_journey return true" do
      touch_in
      expect(@oyster).to be_in_journey
    end
    it "should raise error when balance below LOWER_LIMIT" do
      expect { subject.touch_in(station) }.to raise_error 'Sorry, you do not have enough money.'
    end
    it "create hash with entry station as in value" do
      touch_in
      expect(@oyster.journeys[-1]).to eq ({in: station})
    end
  end

  describe '#touch_out' do

    it { is_expected.to respond_to(:touch_out).with(1).argument}

    it "should raise if not in_journey" do
      expect { subject.touch_out(exit_station) }.to raise_error "Not in journey, cannot touch out."
    end
    it "should make in_journey return false" do
      touch_in
      touch_out
      expect(@oyster).to_not be_in_journey
    end
    it "should reduce balance on card by fare(1)" do
      touch_in
      expect{ touch_out }.to change { @oyster.balance }.by (-Oystercard::MINIMUM_CHARGE)
    end
    it "Retain exit station" do
      touch_in
      touch_out
      expect(@oyster.journeys[-1]).to include(out: exit_station)
    end
  end
end
