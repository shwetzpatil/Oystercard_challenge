require 'oystercard'

describe Oystercard do
      it { is_expected.to respond_to(:balance) }
      describe '#initialize' do
        it 'Is initially empty' do
          expect(subject.balance).to eq(0)
        end
      end

end
