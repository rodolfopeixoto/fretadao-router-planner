require 'rails_helper'

RSpec.describe SearchRouteValidator do
  let!(:logistic_mesh) { FactoryBot.build(:logistic_mesh) }
  let!(:search_params) do
    {
      map: 'SP',
      source: 'a',
      destination: 'd',
      autonomy_km: '10',
      amount_liter: '2.5'
    }
  end
  let!(:search_params_fail) do
    {
      map: '',
      source: '6',
      destination: '8',
      autonomy_km: 'a',
      amount_liter: 'a'
    }
  end

  describe '.call' do
    context 'when there are valid params' do
      it 'return true' do
        search_validator = described_class.call(
          search_params
        )
        expect(search_validator).to be true
      end
    end
    context 'when there are not valid params' do
      it 'return true' do
        search_validator = described_class.call(
          search_params_fail
        )
        expect(search_validator).to be false
      end
    end
  end
end
