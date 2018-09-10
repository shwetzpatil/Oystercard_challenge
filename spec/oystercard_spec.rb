require 'oystercard'

describe Oystercard do
      it { is_expected.to respond_to(:balance) }
      it { is_expected.to respond_to(:top_up).with(1).argument }
      it { is_expected.to respond_to(:ticket_fare).with(1).argument }
      it { is_expected.to respond_to(:touch_in) }
      it { is_expected.to respond_to(:touch_out) }
      it { is_expected.to respond_to(:in_journey?) }

      describe '#initialize' do
        it 'Is initially empty' do
          expect(subject.balance).to eq(0)
        end
      end

      describe '#top_up' do
        it 'top ups the balance in oystercard' do
          amount = 10
          subject.top_up(amount)
          expect(subject.balance).to eq(10)
        end

        it 'checks for maximum top up limit' do
          expect(Oystercard::MAX_LIMIT).to eq(90)
        end

        it 'Prevents top_up of more than max limit' do
          maximum_limit = Oystercard::MAX_LIMIT
          subject.top_up(maximum_limit)
          expect { subject.top_up(0.01) }.to raise_error("Maximum limit is £#{maximum_limit}")
        end
      end

     describe '#ticket_fare' do
       it 'Deducts the fare of the ticket' do
         maximum_limit = Oystercard::MAX_LIMIT
         subject.top_up(maximum_limit)
         cost = 10
         subject.ticket_fare(cost)
         expect(subject.balance).to eq(maximum_limit - cost)
       end
   end

    describe '#touch_in' do
      it 'Starts journey' do
        subject.top_up(1)
        expect(subject.touch_in).to eq true
      end

      it 'raises error if balance goes below 1' do
        subject.top_up(0.99)
        expect{ subject.touch_in }.to raise_error('Insufficient funds')
      end

    end

    describe '#touch_out' do
      it 'Ends journey' do
        subject.top_up(1)
        subject.touch_in
        expect(subject.touch_out).to eq false
      end
    end

    describe '#in_journey?' do
      it 'Tells if in journey' do
        subject.top_up(1)
        subject.touch_in
        expect(subject.in_journey?).to eq(true)
      end
      it 'Tells if not in journey' do
        subject.touch_out
        expect(subject.in_journey?).to eq(false)
      end
    end
end
