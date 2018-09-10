require 'oystercard'

describe Oystercard do
      it { is_expected.to respond_to(:balance) }
      it { is_expected.to respond_to(:top_up).with(1).argument }

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
      end

end
