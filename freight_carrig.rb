class FreightCarrig < Carrig
  attr_reader :cargo_capacity

  def initialize(number)
    super(number)
    @weight = 0
    amount_capacity
  end

  def amount_capacity
    @cargo_capacity ||= 0
    puts 'Укажите общую грузоподъемность в кг:'
    @cargo_capacity = gets.chomp.to_i
  end

  def increase_weight(amount)
    @weight += amount
  end

  def show_weight
    puts "Вагон загружен на #{@weight}кг."
  end

  def show_free_weight
    puts "Оставшаяся недогруженность: #{@cargo_capacity - @weight}кг."
  end

  def to_s
    super + "грузоподъемность: #{cargo_capacity}"
  end
end
