loop do
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
  puts "Starting point: #{@starting}"
  puts "Today's target: #{@target}"
  puts "Remaining today: #{@target - @current}"
  puts
  puts "Current count: #{@current} [#{@progress}/#{@quota}] [%.3f%%]" % @percent

  sleep 1
end