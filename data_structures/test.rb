grid = Array.new(8){Array.new(8){0}}

def print_grid(grid)
  grid.size.times do |i|
    i.size.times do |j|
      print "#{grid[i][j] < 10 ? 0 : ''}#{grid[i][j]} "
    end
    puts
  end
end

print_grid(grid)

def next_y(x, move)
  if move == 0
    x = x + 2
  elsif move == 1
    x = x + 1
  elsif move == 2
    x = x - 1
  elsif move == 3
    x = x - 2
  elsif move == 4
    x = x - 2
  elsif move == 5
    x = x - 1
  elsif move == 6
    x = x + 1
  elsif move == 7
    x = x + 2
  end

  if x < 0 || x > 7
    return -1
  else
    return x
  end
end

def next_x(y, move)
  if move == 0
    y = y + 1
  elsif move == 1
    y = y + 2
  elsif move == 2
    y = y + 2
  elsif move == 3
    y = y + 1
  elsif move == 4
    y = y - 1
  elsif move == 5
    y = y - 2
  elsif move == 6
    y = y - 2
  elsif move == 7
    y = y - 1
  end

  if y < 0 || y > 7
    return -1
  else
    return y
  end
end

def solve(x,y,number, grid)
  
  move = 0

  return 1 if number == 64
  if grid[x][y] == 0
    
    while move < 8 
      if next_x(x, move) != -1 && next_y(y, move) != -1
        grid[x][y] = number
        if solve(next_x(x, move),next_y(y, move),number + 1, grid)
          return true
        end
      end
      move += 1
    end
    grid[x][y] = 0
  end
  
  return false
end

solve(0, 0, 0, grid)
puts
print_grid(grid)