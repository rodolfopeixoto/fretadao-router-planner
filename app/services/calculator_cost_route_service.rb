class CalculatorCostRouteService < ApplicationService

  attr_reader :total_distance, :autonomy_km, :amount_liter

  def initialize(total_distance, autonomy_km, amount_liter)
    @total_distance = total_distance
    @autonomy_km = autonomy_km
    @amount_liter = amount_liter
  end

  def call
    calculator_cost
  end

  def calculator_cost
    (total_distance / autonomy_km) * amount_liter
  end
end
