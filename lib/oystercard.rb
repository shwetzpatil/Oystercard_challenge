require_relative 'journey'
class Oystercard

  attr_reader :balance, :entry_station, :journey
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  def initialize(journey=Journey.new)
    @balance = 0
    @entry_station = nil
    @journey = journey
  end

  def top_up(value)
    fail "Value exceeds maximum allowed: #{MAXIMUM_BALANCE}" if value + @balance > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    fail "Balance too low" if @balance < MINIMUM_BALANCE
    @entry_station = station
    @journey.start_journey(@entry_station)
  end

  def touch_out(station)

    deduct(MINIMUM_FARE)
    @entry_station = nil
    @journey.exit_journey(station)
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
