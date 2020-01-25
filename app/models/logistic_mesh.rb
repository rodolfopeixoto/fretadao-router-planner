class LogisticMesh < ApplicationRecord
  validates :map, :routes, presence: true
end
