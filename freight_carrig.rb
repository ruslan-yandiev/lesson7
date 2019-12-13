class FreightCarrig < Carrig
  attr_reader :cargo_capacity

  def initialize(number)
    super(number)
    @weight = 0
    @free_weight = 0
    amount_capacity
  end

  def amount_capacity
    @cargo_capacity ||= 0
    puts 'Укажите общую грузоподъемность в кг:'
    @cargo_capacity = gets.chomp.to_i
  end

  def increase_weight(amount)
    if amount <= @cargo_capacity
      @weight += amount
      @free_weight = @cargo_capacity - @weight
    else
      puts "Вагон может вместить только #{cargo_capacity}кг."
    end
  end

  def show_weight
    puts "Вагон загружен на #{@weight}кг."
  end

  def show_free_weight
    @free_weight = @cargo_capacity - @weight
    puts "Оставшаяся недогруженность: #{@free_weight}кг."
  end

  def to_s
    super + "грузоподъемность: #{cargo_capacity}, загружен на #{@weight}кг., недогруженность #{@free_weight}кг."
  end
end
