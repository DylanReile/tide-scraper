require_relative "tide_station"

locations = [
  "Half-Moon-Bay-California",
  "Huntington-Beach",
  "Providence-Rhode-Island",
  "Wrightsville-Beach-North-Carolina"
]

locations.each do |location|
  puts "#{location} has the following daylight lowtides:"

  TideStation.new(location).days.each do |day|
    if daylight_lowtide = day.daylight_lowtide
      puts "#{daylight_lowtide.tidal_height_meters} on #{day.date} at #{daylight_lowtide.time} #{daylight_lowtide.timezone}" 
    end
  end

  puts "_____________________________________________________"
end
