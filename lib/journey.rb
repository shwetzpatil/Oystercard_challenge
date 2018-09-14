class Journey
attr_reader :journey_history

  def initialize
    @journey_history = []
  end

  def start_journey (entry_station)
    @journey_history.push({entry_station: entry_station})
  end 

  def exit_journey(exit_station)
    @journey_history[-1][:exit_station] = exit_station
  end
end