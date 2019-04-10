class Journey

# rough outline

def initialize
  @entry_station
  @exit_station
  @in_journey = false
end

attr_reader :in_journey, :entry_station, :exit_station

def in_journey?
  @entry_station ? true : false
end

# needs to indentify incomplete journeys

end
