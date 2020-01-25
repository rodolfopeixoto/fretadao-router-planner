require 'rails_helper'

RSpec.describe LogisticMeshValidator do
  let!(:logistic_mesh) { FactoryBot.attributes_for(:logistic_mesh) }
  let!(:logistic_mesh_fail) { FactoryBot.attributes_for(:logistic_mesh, :fail) }

  describe '.call' do
    context 'when there are valid map and routes' do
      it 'return true' do
        logistic_mesh_validator = LogisticMeshValidator.call(
          logistic_mesh[:map],
          logistic_mesh[:routes]
        )
        expect(logistic_mesh_validator).to be true
      end
    end
    context 'when there are not valid map and routes' do
      it 'return true' do
        logistic_mesh_validator = LogisticMeshValidator.call(
          logistic_mesh_fail[:map],
          logistic_mesh_fail[:routes]
        )
        expect(logistic_mesh_validator).to be false
      end
    end
  end
end
