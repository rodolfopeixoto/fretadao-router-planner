require 'swagger_helper'

describe 'search logistic mesh and logistic mesh request API' do
  path '/api/v1/logistic_meshes/search' do
    get 'Search the logistic mesh' \
        'request and logistic mesh if parameters are valid' do
      tags 'Api::V1::LogisticMeshes'
      consumes 'application/json'
      parameter name: :map,
                in: :query,
                type: :string,
                required: true,
                description: 'Map: ex: SP'
      parameter name: :source,
                in: :query,
                type: :string,
                required: true,
                description: 'Source: ex: A'
      parameter name: :destination,
                in: :query,
                type: :string,
                required: true,
                description: 'Destination: ex: B'
      parameter name: :autonomy_km,
                in: :query,
                type: :string,
                required: true,
                description: 'Autonomy in KM/L: ex 10'
      parameter name: :amount_liter,
                in: :query,
                type: :string,
                required: true,
                description: 'Amount of liter: ex 2.50'

      response '200', 'it searchs logistic mesh when params are valid' do
        schema type: :object,
               properties: {
                 routes: { type: :string },
                 cost: { type: :string }
               }

        let!(:logistic_mesh) { FactoryBot.create(:logistic_mesh) }
        let!(:map) { 'SP' }
        let!(:source) { 'A' }
        let!(:destination) { 'G' }
        let!(:autonomy_km) { '10' }
        let!(:amount_liter) { '2.5' }
        run_test!
      end

      response '422', 'it does not search when params are invalid' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }

        let!(:logistic_mesh) { FactoryBot.create(:logistic_mesh) }
        let!(:map) { '3' }
        let!(:source) { 'A' }
        let!(:destination) { '10' }
        let!(:autonomy_km) { '10' }
        let!(:amount_liter) { '2.5' }
        run_test!
      end
    end
  end
end
