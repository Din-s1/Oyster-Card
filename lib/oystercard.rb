class Oystercard

  DEFAULT_LIMIT = 90
  LOWER_LIMIT = 1
  MINIMUM_CHARGE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station
    @journeys = []
  end

  def balance
    @balance
  end

  def entry_station
    @entry_station
  end

  def journeys
    @journeys
  end

  def top_up(value)
    raise "Top up not possible, limit of #{DEFAULT_LIMIT} reached." if limit_reached?(value)
    @balance += value
  end

  def limit_reached?(value)
    @balance + value > DEFAULT_LIMIT
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Sorry, you do not have enough money." if @balance < LOWER_LIMIT
    @entry_station = station
    journey = {in: station}
    @journeys << journey
  end

  def touch_out(station)
    raise "Not in journey, cannot touch out." if !in_journey?
    deduct(MINIMUM_CHARGE)
    @journeys[-1][:out] = station
    @entry_station = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

end
