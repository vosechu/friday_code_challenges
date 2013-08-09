n = 2680
total = 0

n.times do |i|
  sum = 1
  i.times do |j|
    sum *= j+1
  end
  total += sum
end

puts "last six numbers: #{total % 1000000}"