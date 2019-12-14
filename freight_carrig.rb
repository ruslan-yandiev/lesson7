class FreightCarrig < Carrig
  def to_s
    super + "грузоподъемность: #{@amount}, загружен на #{@amount_now}кг., недогруженность #{@free_amount}кг."
  end
end
