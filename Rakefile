# encoding: utf-8
require './fetcher'

task :default => [:run]

file 'locations.yml' => 'locations.yml.example' do
  cp 'locations.yml.example', 'locations.yml'
end

file 'wu.key' do
  warn "You need to put your Wunderground.com API key in wu.key"
  exit
end

desc "Compare weather in San Francisco using Wunderground.com"
task :run => ['wu.key', 'locations.yml'] do |t|
  key = File.read('wu.key').chomp
  locations = YAML.load_file('locations.yml')['locations']

  Fetcher.new(key, locations).run
end
