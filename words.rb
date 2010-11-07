@goal_string = File.open('wordcount.dat') { |f| f.read nil }

@starting = @goal_string[/starting\W+(\d+)/, 1].to_i
if @goal_string =~ /target\W+(\d+)/
  @target = $1.to_i
else
  quota_str = @goal_string[/quota\W+(\d+)/, 1] || '1667'
  @target = @starting + quota_str.to_i
end

@current = `wc -w chapter*.txt | grep total`.to_i
puts "Current count: #{@current}"
puts "Today's target: #{@target}"
puts "Remaining today: #{@target - @current}"
