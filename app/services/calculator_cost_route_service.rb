class CalculatorCostRouteService < ApplicationService

  attr_reader :total_distance, :autonomy_km, :amount_liter

  def initialize(total_distance, autonomy_km, amount_liter)
    @total_distance = total_distance.to_f
    @autonomy_km = autonomy_km.to_f
    @amount_liter = amount_liter.to_f
  end

  def call
    calculator_cost.to_s
  end

  def calculator_cost
    (total_distance  * amount_liter ) / autonomy_km
  end
end
