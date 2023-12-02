def valid_game_num(line)
  game_number = get_game_num(line)
  games = get_dice_rolls(line)
  games.each do |game|
    game.each do |color, roll|
      if roll.to_i > MAXIMUMS[color.to_sym]
        return
      end
    end
  end
  puts "Valid game: #{game_number}"
  game_number
end

def get_game_power(line)
  minimums = {red: 0, green: 0, blue: 0}
  games = get_dice_rolls(line)
  games.each do |game|
    game.each do |color, roll|
      if roll.to_i > minimums[color.to_sym]
        minimums[color.to_sym] = roll.to_i
      end
    end
  end
  verify_minimums(minimums)
  puts "Minimums: #{minimums}"
  minimums[:red] * minimums[:green] * minimums[:blue]
end

def verify_minimums(minimums)
  minimums.each do |color, minimum|
    if minimum == 0
      raise "Minimum not set for #{color}"
    end
  end
end

def get_game_num(line)
  first_num_index = line.index(' ') + 1
  last_num_index = line.index(':') - 1
  line[first_num_index..last_num_index].to_i
end

def get_dice_rolls(line)
  parsed_games = []
  games = line[line.index(':') + 2..-1].split(';')
  games.each do |game|
    parsed_games << parse_game(game)
  end
  parsed_games
end

def parse_game(raw_game)
  parsed_game = {}
  game = raw_game.split(',')
  game.each do |roll|
    roll = roll.strip
    if roll == ''
      next
    end
    roll_arr = roll.split(' ')
    parsed_game[roll_arr[1]] = roll_arr[0]
  end
  parsed_game
end

lines = File.read('day-2-input.txt').split("\n")
valid_games = []

#### Part 1

MAXIMUMS = {
  'red': 12,
  'green': 13,
  'blue': 14
}


lines.each do |line|
  game_number = valid_game_num(line)
  valid_games << game_number if game_number
end


#### Part 2
lines.each do |line|
  valid_games << get_game_power(line)
end

####

puts "Valid games: #{valid_games.sum}"
