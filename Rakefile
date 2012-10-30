# encoding: utf-8
require './fetcher'

task :default => [:run]

file 'wu.key' do
  warn "You need to put your Wunderground.com API key in wu.key"
  exit
end

desc "Compare weather in San Francisco using Wunderground.com"
task :run => 'wu.key' do |t|
  key = File.read('wu.key').chomp

  Fetcher.new(key).run
end
