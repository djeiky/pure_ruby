require_relative './carrige'

class CargoCarrige < Carrige
  attr_reader :load_weight, :weight

  def initialize(weight, number)
    super('Cargo', number)
    @load_weight = weight
    @weight = 0
  end

  def add_weight(weight)
    @weight += weight if (@weight + weight) < @load_weight
  end

  def remain_weight
    @load_weight - @weight
  end

  private

  attr_writer :load_weight, :weight
end
