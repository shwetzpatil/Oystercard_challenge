require_relative 'station'

class Oystercard
attr_accessor :balance
  def initialize(balance = 0)
    @balance = balance
    @journey_status = false
  end
  MAX_LIMIT = 90
  MINIMUM_CHARGE = 2
  def top_up(amount)
    fail "Maximum limit is £90" if (@balance + amount > MAX_LIMIT)
    @balance += amount
  end

  def ticket_fare(cost = MINIMUM_CHARGE)
    @balance -= cost
  end

  def touch_in
    fail 'Insufficient funds' if @balance < 1
    @journey_status = true
  end

  def touch_out
    ticket_fare(MINIMUM_CHARGE)
    @journey_status = false
  end


  def in_journey?
    @journey_status
  end

  private


end
