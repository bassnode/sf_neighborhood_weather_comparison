require 'bundler'
Bundler.require :default

class Fetcher
  include CommandLineReporter
  attr_accessor :wu, :locations, :weather

  def initialize(api_key)
    self.formatter = 'progress'
    self.wu = Wunderground.new(api_key)
    self.weather = []
    self.locations = {
      'Cole Valley'  => 'pws:KCASANFR110',
      'Bernal'       => 'pws:KCASANFR135',
      'Mt. Davidson' => 'pws:KCASANFR129',
      'Potrero'      => 'pws:KCASANFR53',
      'GG Heights'   => 'pws:KCASANFR46'
    }
  end

  def fetch_weather!
    report do
      locations.each_with_index do |(name, lookup), index|
        result = wu.conditions_for(lookup)
        weather << [name, result['current_observation']]

        progress
      end
    end

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
          #column res['observation_location']['city'].split(', ').first
          column data['feelslike_f']
          column data['wind_string']
        end
      end
    end
  end
end
