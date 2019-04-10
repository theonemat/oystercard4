class Oystercard

  def initialize
    @balance = 0
    @in_journey = false
  end

  attr_reader :balance, :entry_station

  def top_up(amount)

    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance > MAX_BALANCE

    @balance
  end

  def in_journey?
    !!entry_station
    # @entry_station ? true : false
  end

  def touch_in(station)
    raise 'minimum balance required' unless @balance >= MINIMUM_BALANCE
    @entry_station = station

  end

  def touch_out()
    deduct(MINIMUM_FARE)
    @entry_station = nil

  end

  private

  MAX_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 5

  def deduct(amount)
    @balance -= amount
  end
end
