class Station
  include InstanceCounter

  attr_reader :train, :name

  NAME = /^[а-яa-z]+\D/i

  @@all = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
    @@all << self
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise 'Name can`t be nil' if @name.nil?
    raise 'Name can`t be empty string' if @name == ''
    raise 'Name has invalid format' if @name !~ NAME
  end

  def self.all
    @@all
  end

  def get_train(train)
    @trains << train
    puts "На станцию #{name} прибыл поезд: #{train.class},  №#{train.number}, произведенный компанией #{train.name_manufacturer}"
  end

  def show_trains_info(type = nil)
    if type
      @trains.each { |train| puts "number train: #{train.number}, type of train: #{train.class}, вагонов: #{train.show_carriages}" }
    else
      puts "На станции #{name}:"
      @trains.each.with_index(1) { |train, index| puts "#{index}. находится поезд #{train.class} №#{train.number}" }
    end
  end

  def send_train(train)
    puts "Со станции #{name} отправился поезд: #{train.class}  №#{train.number}"
    @trains.delete(train)
  end

  protected :validate!
end

