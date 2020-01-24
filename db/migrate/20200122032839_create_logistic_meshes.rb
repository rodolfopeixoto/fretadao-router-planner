class CreateLogisticMeshes < ActiveRecord::Migration[6.0]
  def change
    create_table :logistic_meshes do |t|
      t.string :map, null: false
      t.string :routes, array: true, null: false

      t.timestamps
    end
  end
end
