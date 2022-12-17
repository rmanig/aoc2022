instructions = []
File.foreach('input.txt').each do |line |
  parts = line.split(" ")
  if parts[0] == "addx"
    instructions << [parts[1].to_i, 2]
  else
    instructions << [nil, 1]
  end
end

signalStrength = 0
screen = ""
register = 1
instruction = nil
cycle = 0
while instructions.length > 0 || instruction != nil
  cycle += 1
  if instruction == nil
    instruction = instructions.shift
  end

  pixel = "."
  if cycle % 40 >= register && cycle % 40 <= register + 2
    pixel = "#"
  end

  if cycle % 40 != 0
    screen += pixel
  else
    screen += "\n"
  end

  if cycle == 20  || cycle == 60 || cycle == 100 || cycle == 140 || cycle == 180 || cycle == 220
    signalStrength += cycle * register
  end

  if instruction[1] > 1
    instruction[1] -= 1
  else
    if instruction[0] != nil
      register += instruction[0]
    end
    instruction = nil
  end
end

puts("solution one is : " + signalStrength.to_s)
puts("solution two is: \n" + screen)