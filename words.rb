@starting = 6790
@quota = 2262
@target = @starting + @quota

@current = `wc -w chapter*.txt | grep total`.to_i
puts "Current count: #{@current}"
puts "Remaining today: #{@target - @current}"
