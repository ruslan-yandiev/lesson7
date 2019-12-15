class Сonstructor
  attr_reader :collection, :stations, :routes, :cargo_trains, :passenger_trains, :f_carrigs, :p_carrigs

  def initialize
    @collection = [Station, Route, CargoTrain, PassengerTrain, FreightCarrig, PassengerCarrig]
    @stations = []
    @routes = []
    @cargo_trains = []
    @passenger_trains = []
    @f_carrigs = []
    @p_carrigs = []
  end

  def constructor(number, amount)
    unless amount >= 1
      puts 'Неверно задано колличество создаваемых объектов!!!'
      exit
    end

    1.upto(amount) do
      if @collection[number].nil?
        puts 'Вы неверно указали номер!!!'
      elsif @collection[number] == Station
        begin
          puts 'Введите имя станции:'
          name = gets.chomp
          object = @collection[number].new(name)
          @stations << object
        rescue RuntimeError => e
          puts e
          retry
        end
      elsif  @collection[number] == Route
        begin
          puts 'Введите имя маршрута:'
          name = gets.chomp
          object = @collection[number].new(name)
          @routes << object
        rescue RuntimeError => e
          puts e
          retry
        end
      elsif  @collection[number] == CargoTrain
        begin
          puts "Введите номер.\nДопустимый формат: три буквы или цифры в любом порядке,
          \rнеобязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса."
          numb = gets.chomp
          object = @collection[number].new(numb)
          @cargo_trains << object
        rescue RuntimeError => e
          puts e
          retry
        end
      elsif  @collection[number] == PassengerTrain
        begin
          puts "Введите номер.\nДопустимый формат: три буквы или цифры в любом порядке,
          \rнеобязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса."
          numb = gets.chomp
          object = @collection[number].new(numb)
          @passenger_trains << object
        rescue RuntimeError => e
          puts e
          retry
        end
      elsif  @collection[number] == FreightCarrig
        begin
          puts "Введите номер.\nДопустимый формат: три буквы или цифры в любом порядке,
          \rнеобязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса."
          numb = gets.chomp

          puts 'Укажите общую грузоподъемность в кг:'
          amounts = gets.chomp.to_i

          object = @collection[number].new(numb, amounts)
          @f_carrigs << object
        rescue RuntimeError => e
          puts e
          retry
        end
      elsif  @collection[number] == PassengerCarrig
        begin
          puts "Введите номер.\nДопустимый формат: три буквы или цифры в любом порядке,
          \rнеобязательный дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса."
          numb = gets.chomp

          puts 'Укажите общее колличество мест в вагоне:'
          amounts = gets.chomp.to_i

          object = @collection[number].new(numb, amounts)
          @p_carrigs << object
        rescue RuntimeError => e
          puts e
          retry
        end
      end
    end

    @collection.delete_at(number)
  end

  def start
    show_all_object
    p Station.all
    route!
    correct_route
    connect_carrig!
    freight_carrig_filling
    passenger_carrig_filling
    show_carr!
    cargo_carrige_delete!
    passenger_carrige_delete!
    show_carr!
    cargo_train_add_route
    passenger_train_add_route
    station_info_train
    go_go
    go_back
    station_info_train
    find!
    show_amount_object
  end

  def show_amount_object
    puts
    puts "Всего создано:
    \n#{PassengerTrain.instances} пассажирских поезда.
    \n#{CargoTrain.instances} грузовых поезда.
    \n#{Route.instances} маршрута.
    \n#{Station.instances} станции."
  end

  def freight_carrig_filling
    puts 'Хотите загрузить грузовой вагон?(да/нет)'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      @f_carrigs.each_with_index { |carrig, index| puts "#{index} - #{carrig}" }

      puts 'Укажите вагон который нужно загрузить:'
      number = gets.chomp.to_i

      puts 'Укажите вес груза:'
      weight = gets.chomp.to_i

      @f_carrigs[number].increase_amount(weight) if @f_carrigs[number]

      self.freight_carrig_filling
    end
  end

  def passenger_carrig_filling
    puts 'Хотите занять место в пассажирском вагоне?(да/нет)'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      @p_carrigs.each_with_index { |carrig, index| puts "#{index} - #{carrig}" }

      puts 'Укажите вагон который нужно занять:'
      number = gets.chomp.to_i

      @p_carrigs[number].increase_amount if @p_carrigs[number]

      self.passenger_carrig_filling
    end
  end

  def station_info_train
    puts 'Хотите отобразить поезда на станции?(да/нет)?'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      @stations.each_with_index { |station, index| puts "#{index} - #{station.name}" }

      print 'Укажите станцию:'
      number = gets.chomp.to_i

      @stations[number].show_trains_info if @stations[number]

      self.station_info_train
    end
  end

  def find!
    puts 'Хотите отобразить объект грузового поезда по его номеру?(да/нет)?'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      print 'Укажите номер поезда:'
      number = gets.chomp

      CargoTrain.find(number)
    end

    puts 'Хотите отобразить объект пассажирского поезда по его номеру?(да/нет)?'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      print 'Укажите номер поезда:'
      number = gets.chomp

      PassengerTrain.find(number)
    end

    puts 'Хотите закончить процедуру отображение объектов поездов (да/нет)'
    yes_or_no = gets.chomp

    self.find! if yes_or_no != 'да'
  end

  def route!
    puts "Необходимо составить маршрут следования и добавить станции к созданным маршрутам.\nКакие станции из созданных вы хотите добавить в маршрут?"

    @routes.each_with_index do |type, index|
      puts "\t#{index}. Маршрут: #{type.name}"
    end
    puts 'Выберите маршрут:'
    number_r = gets.chomp.to_i

    unless @routes[number_r]
      puts 'Неверно выбран маршрут!!!'
      self.route!
    end

    begin
      @stations.each_with_index do |type, index|
        puts "\t#{index}. Станция: #{type.name}"
      end

      puts "Укажите номер станции.\nСтанции будут добавляться по порядку, от начальной и до конечной."
      number_s = gets.chomp.to_i

      if @stations[number_s] && @routes[number_r].route.include?(@stations[number_s]) == false
        @routes[number_r].add_stations(@stations[number_s])
      else
        puts 'Неверно указана станция!!!'
      end

      puts 'Хотите добавить еще станцию? (да/нет)'
      yes_or_no = gets.chomp
    end while yes_or_no != 'нет' && yes_or_no != ''

    puts 'Хотите сформировать новый маршрут? (да/нет)'
    yes_or_no = gets.chomp
    self.route! if yes_or_no == 'да'
  end

  def correct_route
    puts 'Скорректировать маршрут? (да/нет)'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      @routes.each_with_index do |type, index|
        puts "\t#{index}. Маршрут: #{type.name}"
      end

      puts 'Выберите маршрут для коррекции:'
      number_r = gets.chomp.to_i

      unless @routes[number_r]
        puts 'Неверно выбран маршрут!!!'
        self.correct_route
      end


      begin
        @routes[number_r].route.each_with_index do |type, index|
          puts "\t#{index}. Станция: #{type.name}"
        end

        print "Укажите номер станции которую нужно удалить: "
        number_s = gets.chomp.to_i

        if @routes[number_r].route.include?(@routes[number_r].route[number_s])
            @routes[number_r].delete_way(number_s)
        else
          puts 'Неверно указана станция!!!'
        end

        puts 'Хотите еще удалить станцию? (да/нет)'
        yes_or_no = gets.chomp
      end while yes_or_no != 'нет' && yes_or_no != ''

      puts 'Хотите еще откорректировать маршрут (да/нет)?'
      yes_or_no = gets.chomp
      self.correct_route if yes_or_no == 'да'
    end
  end

  def connect_carrig!
    puts 'Присоединить к созданным поездам имеющиеся вагоны (да/нет)?'
    yes_or_no = gets.chomp

    connect_carrig if yes_or_no == 'да'
  end

  def show_carr!
    puts 'Отобразить информацию о вагонах у поездов (да/нет)?'
    yes_or_no = gets.chomp

    show_carr if yes_or_no == 'да'
  end

  def cargo_carrige_delete!
    puts 'Хотите отцепить товарные вагоны (да/нет)?'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      puts 'сколько вагонов отцепить?'
      quantity_carrig = gets.chomp.to_i

      puts "У какого поезда отцепить?\nВыберите номер поезда:"
      @cargo_trains.each_with_index {|train, index| puts "#{index}. Поезд:#{train.number}"}
      train_num = gets.chomp.to_i

      cargo_carrige_delete(quantity_carrig, train_num) if @cargo_trains[train_num]
    end
  end

  def passenger_carrige_delete!
    puts 'Хотите отцепить пассажирские вагоны (да/нет)?'
    yes_or_no = gets.chomp

    if yes_or_no == 'да'
      puts 'сколько вагонов отцепить?'
      quantity_carrig = gets.chomp.to_i

      puts "У какого поезда отцепить?\nВыберите номер поезда:"
      @passenger_trains.each_with_index {|train, index| puts "#{index}. Поезд:#{train.number}"}
      train_num = gets.chomp.to_i

      passenger_carrige_delete(quantity_carrig, train_num) if  @passenger_trains[train_num]
    end
  end

  def cargo_train_add_route
    @cargo_trains.each do |train|
      puts "Укажите маршрут для грузового поезда №#{train.number}"

      @routes.each_with_index do |type, index|
        puts "\t#{index}. Маршрут: #{type.name}"
      end

      print 'Выберите маршрут:'
      number_r = gets.chomp.to_i

      unless @routes[number_r]
        puts 'Неверно выбран маршрут!!!'
        self.cargo_train_add_route
      end

      train.add_route(@routes[number_r])
    end
  end

  def passenger_train_add_route
    @passenger_trains.each do |train|
      puts "Укажите маршрут для пассажирского поезда №#{train.number}"

      @routes.each_with_index do |type, index|
        puts "\t#{index}. Маршрут: #{type.name}"
      end

      print 'Выберите маршрут:'
      number_r = gets.chomp.to_i

      unless @routes[number_r]
        puts 'Неверно выбран маршрут!!!'
        self.passenger_train_add_route
      end

      train.add_route(@routes[number_r])
    end
  end

  def go_go
    begin
      puts 'Хотите отправить поезда в путь (да/нет)'
      yes_or_no = gets.chomp

      if yes_or_no == 'да'
        go_go_cargo(@cargo_trains.size)
        go_go_passenger(@passenger_trains.size)
      end
    end while yes_or_no != 'нет'
  end

  def go_back
    begin
      puts 'Хотите отправить поезда в обратный путь (да/нет)'
      yes_or_no = gets.chomp

      if yes_or_no == 'да'
        go_back_cargo(@cargo_trains.size)
        go_back_passenger(@passenger_trains.size)
      end
    end while yes_or_no != 'нет'
  end

  protected

  def connect_carrig
    @cargo_trains.each do |train|
      @f_carrigs.each { |carrig| train.add_carrig(carrig) }
    end

    @passenger_trains.each do |train|
      @p_carrigs.each { |carrig| train.add_carrig(carrig) }
    end
  end

  def show_carr
    @cargo_trains.each do |train|
      train.show_carriages
    end

    @passenger_trains.each do |train|
      train.show_carriages
    end
  end

  def cargo_carrige_delete(carrig_cum, train_num)
    carrig_cum.times { @cargo_trains[train_num].delete_carrig }
  end

  def passenger_carrige_delete(carrig_cum, train_num)
    carrig_cum.times { @passenger_trains[train_num].delete_carrig }
  end

  def go_go_cargo(num)
    num.times { |index| @cargo_trains[index].go }
  end

  def go_go_passenger(num)
    num.times { |index| @passenger_trains[index].go }
  end

  def go_back_cargo(num)
    num.times { |index| @cargo_trains[index].go_back }
  end

  def go_back_passenger(num)
    num.times { |index| @passenger_trains[index].go_back }
  end

  def show_all_object
  self.stations.each {|x| p x}
  self.routes.each {|x| p x}
  self.cargo_trains.each {|x| p x}
  self.passenger_trains.each {|x| p x}
  self.f_carrigs.each {|x| p x}
  self.p_carrigs.each {|x| p x}
  end
end
