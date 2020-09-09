#!/usr/bin/env ruby

# This script requires restclient and colorize gems to be installed
require 'restclient'
require 'benchmark'
require 'colorize'
require 'json'

def format_duration(duration)
  "#{duration.round(3)}s".colorize(:green)
end

def format_status(response)
  if response.code >= 400
    "Status: #{response.code.to_s.colorize(:red)} Error: #{json_body(response)["error_class"].colorize(:red)}"
  else
    "Status: #{response.code.to_s.colorize(:green)}"
  end
end

def json_body(response)
  JSON.parse(response.body)
end

def print_request_completed(duration, response)
  puts "Request completed - #{format_status(response)} Duration: #{format_duration(duration.real)}"
end

while(true) do
  url = "localhost:3000/#{ARGV.first}"
  puts "Starting request to #{url}"
  response = nil
  duration = Benchmark.measure do
    RestClient.get(url) { |res| response = res }
  end
  print_request_completed(duration, response)
end