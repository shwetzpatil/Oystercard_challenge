require 'oystercard'

describe Oystercard do
      it { is_expected.to respond_to(:balance) }
      it { is_expected.to respond_to(:top_up).with(1).argument }
      it { is_expected.to respond_to(:ticket_fare).with(1).argument }

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
end
