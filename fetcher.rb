require 'bundler'
Bundler.require :default

class Fetcher
  include CommandLineReporter
  attr_accessor :wu, :locations, :weather

  def initialize(api_key, locations)
    self.formatter = 'progress'
    self.wu = Wunderground.new(api_key)
    self.weather = []
    self.locations = locations
  end

  def fetch_weather!
    tg = ThreadGroup.new
    mutex = Mutex.new

    report do
      locations.each_with_index do |(name, lookup), index|
        t = Thread.new do
          wunderground_location = lookup[0..2] != 'pws' ? "pws:#{lookup}" : lookup
          result = wu.conditions_for(wunderground_location)
          mutex.synchronize do
            weather << [name, result['current_observation']]
          end

          progress
        end

        tg.add(t)
      end
    end

    tg.list.each(&:join)

    weather.sort_by!{ |name, data| data['feelslike_f'] }
    weather.reverse!
  end

  def run
    fetch_weather!

    header :title => 'SF Weather Comparison', :width => 75, :color => :blue

    table :border => true do

      row :header => true, :color => 'green'  do
        column 'Where', :width => 15
        column 'Temp', :width => 10
        column 'Wind', :width => 50
      end

      weather.each do |name, data|
        row do
          column name
          column data['feelslike_f']
          column data['wind_string']
        end
      end
    end
  end
end
