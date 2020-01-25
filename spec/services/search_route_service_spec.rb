require 'rails_helper'

RSpec.describe SearchRouteService do
  let!(:logistic_mesh) { FactoryBot.create(:logistic_mesh) }
  let!(:search_params) do
    {
      map: 'SP',
      source: 'A',
      destination: 'G',
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
        search_service = described_class.call(
          search_params
        )
        expect(search_service).to eq(routes: 'A B E G', cost: '3.0')
      end
    end
    context 'when there are not valid params' do
      it 'return true' do
        expect do
          described_class.call(
            search_params_fail
          )
        end .to raise_error('Map not found')
      end
    end
  end
end
