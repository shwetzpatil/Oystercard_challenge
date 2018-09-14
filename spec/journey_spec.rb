require 'journey'

describe Journey do

    # subject { described_class.new([])}

    it { is_expected.to respond_to :journey_history }
    it { is_expected.to respond_to(:start_journey).with(1).argument }
    it { is_expected.to respond_to(:exit_journey).with(1).argument} 

    describe '#start_journey' do
        it 'starts the journey' do
            subject.start_journey('ABC')
            subject.journey_history == [{entry_station:'ABC'}]
        end
    end

    describe '#end_journey' do
        it 'ends the journey' do
            subject.start_journey('ABC')
            subject.exit_journey('XYZ')
            subject.journey_history == [{entry_station: 'ABC', exit_station:'XYZ'}]
        end
    end
end