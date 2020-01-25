require 'rails_helper'

RSpec.describe CalculatorCostRouteService do
  describe '.call' do
    context 'when there are params valid' do
      it 'should be return result' do
        result = described_class.call('25', '10', '2.5')
        expect(result).to eq '6.25'
      end
    end
    context 'when there are params invalid' do
      it 'should be return result' do
        result = described_class.call('a', 'b', '5')
        expect(result).to eq 'NaN'
      end
      it 'should be return result' do
        result = described_class.call('a', 'b', 'a')
        expect(result).to eq 'NaN'
      end
    end
  end
end
