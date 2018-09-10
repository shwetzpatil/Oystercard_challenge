class Oystercard
attr_accessor :balance
  def initialize(balance = 0)
    @balance = balance
    @journey_status = false
  end
  MAX_LIMIT = 90
  def top_up(amount)
    fail "Maximum limit is £90" if (@balance + amount > MAX_LIMIT)
    @balance += amount
  end

  def ticket_fare(cost)
    @balance -= cost
  end

  def touch_in
    @journey_status = true
  end

  def touch_out
    @journey_status = false
  end


  def in_journey?
    @journey_status
  end
end
