class PassengerCarrig < Carrig

  def increase_amount
    super(1)
  end

  def to_s
    super + "вместимость: #{@amount} человек, зянято #{@amount_now} мест, свободно мест: #{free_amount}"
  end
end
