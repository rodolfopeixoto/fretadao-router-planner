class LogisticMeshesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :map, :routes
end
