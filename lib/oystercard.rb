class Oystercard

  def initialize
    @balance = 0
    @in_journey = false
    @journey_list = []
  end

  attr_reader :balance, :entry_station, :journey_list

  def top_up(amount)

    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance > MAX_BALANCE

    @balance
  end

  def in_journey?
    !!entry_station
    # @entry_station ? true : false
  end

  def touch_in(entry_station)
    raise 'minimum balance required' unless @balance >= MINIMUM_BALANCE
    @entry_station = entry_station

  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey_list << {in: entry_station, out: exit_station}
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
