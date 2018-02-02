class Event
  include Virtus.model

  attribute :time, String
  attribute :timezone, String
  attribute :type, String
  attribute :tidal_height_meters, String
end
