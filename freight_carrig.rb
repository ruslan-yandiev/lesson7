class FreightCarrig < Carrig
  attr_reader :cargo_capacity

  def initialize(number)
    super(number)
    @cargo_capacity = 5000
  end

  def to_s
    super + "грузоподъемность: #{cargo_capacity}"
  end
end
