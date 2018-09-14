require 'oystercard'

describe Oystercard do

let(:station) { instance_double("Station", :name => 'ABC', :zone => 1) }
let(:journey_obj) { double(:journey)}

it { is_expected.to respond_to(:balance) }
it { is_expected.to respond_to(:top_up).with(1).argument }
it { is_expected.to respond_to(:touch_in).with(1).argument }
it { is_expected.to respond_to(:touch_out).with(1).argument  }
it { is_expected.to respond_to(:in_journey?) }

  describe "#balance" do

    it 'returns an initial @balance of 0' do
      expect(subject.balance).to eq(0)
    end

  end

  describe "#top_up" do

    it 'updates the balance when passed a value' do
      value = rand(1..50)
      expect{subject.top_up(value)}.to change{subject.balance}.by(value)
    end

    it 'fails if @balance will go over MAXIMUM_BALANCE' do
      value = Oystercard::MAXIMUM_BALANCE + 1
      expect{subject.top_up(value)}.to raise_error("Value exceeds maximum allowed: #{Oystercard::MAXIMUM_BALANCE}")
    end

  end

  describe '#touch_in' do

    it "says your journey has started" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'raises error when @balance is below MINIMUM_BALANCE' do
      expect { subject.touch_in(station) }.to raise_error('Balance too low')
    end

    it 'sets the starting station' do
      entry_station = "ABC"
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(journey_obj).to receive(:start_journey).with(entry_station)
      journey_obj.start_journey(entry_station)
    end
  end

  describe '#touch_out(station)' do

    it "says your journey has finished" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end

    it "deducts journey fare from @balance" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by -(Oystercard::MINIMUM_FARE)
    end

    it 'ends the journey' do
      entry_station = "ABC"
      exit_station = 'XYZ'
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(journey_obj).to receive(:exit_journey).with(exit_station)
      journey_obj.exit_journey(exit_station)
    end


  end

  describe '#in_journey?' do

    it 'shows whether a card is in journey' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'shows whether a card is in journey' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

  end

end
