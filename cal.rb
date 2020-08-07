#!/usr/bin/ruby
require File.join(File.dirname(__FILE__), 'models', 'calendar')

begin
  arg = ARGV[0].nil? ? 'Su' : ARGV[0]
  Calendar.new(arg).execute
rescue StandardError => e
  puts "#{e.class}: #{e.message}"
end
