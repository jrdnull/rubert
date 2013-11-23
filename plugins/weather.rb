require 'cinch'
require 'yahoo_weatherman'

class Weather
  include Cinch::Plugin

  def initialize(bot)
    super bot
    @client = Weatherman::Client.new
  end

  match /weather (.+)/
  def execute(m, location)
     m.reply lookup location
  end

  private

  def lookup(location)
    response = @client.lookup_by_location(location)
    response.location.is_a?(Nokogiri::XML::Node) ? get_weather_text(response) : 'Not found'
  end

  def get_weather_text(r)
    "#{get_location_text r.location} :: #{get_condition_text r.condition, r.units} :: Wind: #{get_wind_text r.wind, r.units}"
  end

  def get_location_text(location)
    "#{location['city']}, #{location['country']}"
  end

  def get_condition_text(condition, units)
    "#{condition['text']}, #{condition['temp']}\u00B0#{units['temperature']}"
  end

  def get_wind_text(wind, units)
    "#{wind['speed']}#{units['speed']}"
  end
end