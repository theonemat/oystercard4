class Journey
MIN_FARE = 1
PENALTY_FARE = 6

def initialize
@journey_full= {}
@entry_station = ''
@exit_station = ''

end

 attr_reader :in_journey, :entry_station, :exit_station, :journey_full
#
def complete?
!(entry_station.empty? || exit_station.empty?)
end
#
# # needs to indentify incomplete journeys
#
# end
#
#
#
# @journey[:out] = exit_station
# @journey_list << @journey
#
# @journey = {in: entry_station}

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

  def start(entry_station)
    @entry_station = entry_station
    @journey_full = {in: entry_station}
  end

  def end(exit_station)
    @exit_station = exit_station
    @journey_full[:out] = exit_station
  end

end
