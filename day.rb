Bundler.require
require_relative "event"

class Day
  include Virtus.model

  attribute :date, String
  attribute :events, Array[Event]  

  # Returns the lowtide event if one occurs between Sunrise and Sunset.
  # Otherwise returns nil.
  def daylight_lowtide
    sun_has_risen = false
    sun_has_set = false

    events.each do |event|
      case event.type
      when "Sunrise"
        sun_has_risen = true
      when "Sunset"
        sun_has_set = true
      when "Low Tide"
        return (sun_has_risen && !sun_has_set) ? event : nil
      end
    end 

    return nil
  end
end
