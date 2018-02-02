require "bundler/setup"
Bundler.require 
require "open-uri"
require_relative "day"

class TideStation
  def initialize(location)
    @location = location
  end

  def days
    # Tide-forecast displays each location event in its own 5-cell row.
    # Some rows begin with an extra, 6th cell in order to delinate dates.
    # Therefore we walk the rows, collecting events and keeping track of which day they're for.
    # When encountering a 6-cell row, the current_day is updated, and the extra cell is popped from
    # the cells array so that the rest of the indices aren't displaced by one.
    current_day = nil
    table_rows.each_with_object([]) do |row, collection|
      cells = row.elements

      if cells.count == 6
        current_day = Day.new(date: cells.shift.content)
        collection << current_day
      end

      current_day.events << Event.new(
        time: cells[0],
        timezone: cells[1],
        tidal_height_meters: cells[2],
        # cells[3] tidal height in feet not used
        type: cells[4]
      )
    end
  end

  private

  def table_rows
    page.xpath("//table/tr")
  end

  def page
    Nokogiri::HTML(open("https://www.tide-forecast.com/locations/#{@location}/tides/latest"))
  end
end
