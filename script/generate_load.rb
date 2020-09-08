#!/usr/bin/env ruby

# This script requires restclient and colorize gems to be installed
require 'restclient'
require 'benchmark'
require 'colorize'

def format_duration(duration)
  "#{duration.round(3)}s".colorize(:green)
end

def format_status_code(status_code)
  if status_code >= 400
    status_code.to_s.colorize(:red)
  else
    status_code.to_s.colorize(:green)
  end
end

def print_request_completed(duration, status_code)
  puts "Request completed - Status: #{format_status_code(status_code)} Duration: #{format_duration(duration.real)}"
end

while(true) do
  url = "localhost:3000/#{ARGV.first}"
  puts "Starting request to #{url}"
  response_status = nil
  duration = Benchmark.measure do
    RestClient.get(url) { |response| response_status = response.code }
  end
  print_request_completed(duration, response_status)
end