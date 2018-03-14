$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'line_log'
require 'time'
require 'pry'

def fixtures_path 
  "#{File.dirname(File.expand_path(__FILE__))}/fixtures"
end