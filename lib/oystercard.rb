class Oystercard

  def initialize
    @balance = 0
    @status = false
    @entry_station = []
  end

  attr_reader :balance
  attr_reader :entry_station

  def top_up(amount)

    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance > MAX_BALANCE

    @balance
  end

  def in_journey?
    @entry_station.length > 0
  end

  def touch_in(station)
    raise 'minimum balance required' unless @balance >= MINIMUM_BALANCE
    @entry_station << station
    in_journey?
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = []
    in_journey?
  end

  private

  MAX_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 5

  def deduct(amount)
    @balance -= amount
  end
end
