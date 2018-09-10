class Oystercard
attr_accessor :balance
  def initialize(balance = 0)
    @balance = balance
  end
  MAX_LIMIT = 90
  def top_up(amount)
    fail "Maximum limit is £90" if (@balance + amount > MAX_LIMIT)
    @balance += amount
  end

  def ticket_fare(cost)
    @balance -= cost
  end
end
