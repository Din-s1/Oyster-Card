class Oystercard

  attr_reader :balance, :in_journey

  DEFAULT_LIMIT = 90
  LOWER_LIMIT = 1

  def initialize(balance = 0, in_journey = false)
    @balance = balance
    @in_journey = in_journey
  end

  def top_up(value)
    raise "Top up not possible, limit of #{DEFAULT_LIMIT} reached." if limit_reached?(value)
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def limit_reached?(value)
    @balance + value > DEFAULT_LIMIT
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Sorry, you do not have enough money." if @balance < LOWER_LIMIT
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
