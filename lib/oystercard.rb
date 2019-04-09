class Oystercard

  def initialize
    @balance = 0
    @status = false
  end

  attr_reader :balance

  def top_up(amount)
    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance > MAX_BALANCE

    @balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @status
  end

  def touch_in
    raise 'minimum balance required' unless @balance >= MINIMUM_BALANCE
    @status = true
  end

  def touch_out
    @status = false
  end

  private

  MAX_BALANCE = 90
  MINIMUM_BALANCE = 1
end
