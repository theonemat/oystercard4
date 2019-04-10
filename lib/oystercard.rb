class Oystercard

  def initialize
    @balance = 0
    @in_journey = false
    @journey_list = []
  end

  attr_reader :balance, :entry_station, :exit_station, :journey_list

  def top_up(amount)

    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance > MAX_BALANCE

    @balance
  end

  def in_journey?
    @entry_station ? true : false # could use: !!entry_station
  end

  def touch_in(entry_station)
    raise 'minimum balance required' unless @balance >= MIN_BALANCE

    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journey_list << {in: entry_station, out: exit_station}
    @entry_station = nil
  end

# should charge for incomplete journey

  private

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 6

  def deduct(amount)
    @balance -= amount
  end
end
