require 'swagger_helper'

describe 'Create logistic mesh and logistic mesh request API' do
  path '/api/v1/logistic_meshes' do
    post 'Create the logistic mesh request and logistic mesh if parameters are valid' do
      tags 'Api::V1::LogisticMeshes'
      consumes 'application/json'
      parameter name: :body,
                in: :body,
                required: true,
                description: 'It creates the logistic mesh request and also',
                schema: {
                  type: :object,
                  properties: {
                    logistic_meshs: {
                      type: :array,
                      items: { type: :string }
                    }
                  }
                }
      response '201', 'it creates logistic mesh when params are valid' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 employee_id: { type: :integer },
                 number: { type: :string },
                 brand: { type: :string }
               }

        let!(:logistic_mesh) { FactoryBot.create(:logistic_mesh) }
        let!(:body) do
          {
            logistic_meshes: {
              map: 'SP',
              routes: logistic_mesh.routes
            }
          }
        end
        run_test!
      end

      response '422', 'it does not create when params are invalid' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       field: { type: :string },
                       messages: { type: :array, items: { type: :string } }
                     }
                   }
                 }
               }
        let!(:body) do
          {
            logistic_meshes: {
              map: 'SP',
              routes: ['2 2 2', 'A C 3', 'B D 2', 'B A 2', 'B E 5', 'C D 1',
                       'C F 6', '2 1 3', 'D E 3', 'D F 5', 'F D 5', 'F C 6',
                       'F G 4', 'E B 5', 'E B 5', 'E D 3', 'E G 5', 'G F 4', 'G E 5']
            }
          }
        end
        run_test!
      end
    end
  end
end
