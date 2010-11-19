#!/bin/env ruby
# Word count script for Nanowrimo '10

require 'optparse'

@options = { :update => false }
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"

  opts.on('-u', '--update', 'Continuously update the screen.') do
    @options[:update] = true
  end
end.parse!

def count
  @goal_string = File.open('wordcount.dat') { |f| f.read nil }

  @starting = @goal_string[/starting\W+(\d+)/, 1].to_i
  if @goal_string =~ /target\W+(\d+)/
    @target = $1.to_i
    @quota = @target - @starting
  else
    @quota = (@goal_string[/quota\W+(\d+)/, 1] || 1667).to_i
    @target = @starting + @quota
  end

  @current = `wc -w chapter*.txt | grep total`.to_i
  @progress = @current - @starting

  @percent = @progress * 100.0 / @quota

  system 'cls'
  puts "  Current Word Count"
  puts
  puts "Starting point: #{@starting}"
  puts "Today's target: #{@target}"
  puts "Remaining today: #{@target - @current}"
  puts
  puts "Current count: #{@current} [#{@progress}/#{@quota}] [%.3f%%]" % @percent
end

if @options[:update]
  loop { count ; sleep 1 }
else
  count
end