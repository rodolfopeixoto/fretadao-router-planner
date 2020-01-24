require 'rails_helper'

RSpec.describe LogisticMesh, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:map) }
    it { should validates_inclusion_of(:routes) }
  end
end
