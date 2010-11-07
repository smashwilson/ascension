@starting = 9119
@quota = 2262
@target = @starting + @quota

@current = `wc -w chapter*.txt | grep total`.to_i
puts "Current count: #{@current}"
puts "Today's target: #{@target}"
puts "Remaining today: #{@target - @current}"
