require_relative 'grid'
require_relative 'player'
require_relative 'human'

class GM

  attr_reader :pvp

  def initialize
    @turn_count = 0
    @p1_turn = true
    @grid = Grid.new
    @local_grid = ["1","2","3","4","5","6","7","8","9"]
    @turn_count = 1
  end

  def welcome
    puts "Welcome to Tic-Tac-Toe!"
  end

  def choose_mode
    mode_chosen =  false
    puts "Would you like to play against a human, or face one of the COMs?"
    puts "1 = PVP"
    puts "2 = PVE"
    choice = gets.chomp

    if choice != "1" && choice != "2"
      puts "Wrong input, please input 1 for PVP or 2 for PVE"
    elsif choice == "1"
      puts "You have chosen PVP"
      @pvp = true
      gets
      system "clear"
      mode_chosen = true
    else
      puts "You have chosen PVE"
      @pvp = false
      gets
      system "clear"
      mode_chosen = true
      # Add dificulty choice
    end

    return mode_chosen
  end

  def get_players pvp
    if pvp
      @p1 = Human.new get_name("Player 1"), get_symbol
      gets
      system "clear"
      @p2 = Human.new get_name("Player 2"), get_symbol
      gets
      system "clear"
    else
      #PVE STUFF
      # @p1 = human
      # @p2 = ai
    end
  end

  def display_Grid
    @grid.draw_self
  end

  def give_turn
    if @pvp
      if @p1_turn
        puts "It's #{@p1.name}'s turn!"
        go_on = true
        while go_on
          go_on = move_valid?(@p1)
        end
        @turn_count +=1
        if someone_won?(@grid.get_grid)
          handle_victory
          return false
        elsif no_moves_left?
          return false
        else
          @p1_turn = false
          return true
        end        
      else
        puts "It's #{@p2.name}'s turn!"
        go_on = true
        while go_on
          go_on = move_valid?(@p2)
        end
        @turn_count +=1
        someone_won?(@grid.get_grid)
        no_moves_left?
        @p1_turn = true
      end
    end
  end

  def move_valid? player
    puts "#{player.name} choose a place in the grid to put your mark by inputing the co-responding number"
    choice = player.choose_move

    if ((@local_grid.include? choice) && choice != @p1.symbol && choice != @p2.symbol)
      @grid.update_current_grid choice, player.symbol
      @local_grid.map! { |el| el == choice ? player.symbol : el }
      return false
    else
      puts "Invalid choice. Please make sure that the square you are trying to go to is unocupied"
      gets
      system "clear"
      return true
    end
  end

  def someone_won? arr
    #check rows
    for i in 0..2
      if arr[i][0] == arr[i][1] && arr[i][1] == arr[i][2]
        return true
      end
    end

    #check columns
    for i in 0..2
      if arr[0][i] == arr[1][i] && arr[1][i] == arr[2][i]
        return true
      end
    end

    #check diagonals
    if arr[0][0] == arr[1][1] && arr[1][1] == arr[2][2] || arr[0][2] == arr[1][1] && arr[1][1] == arr[2][0]
      return true
    end

    return false
  end

  def handle_victory
    system "clear"
    if @pvp
      if @p1_turn
        system "clear"
        puts "#{@p1.name} has won the game!"
      else
        system "clear"
        puts "#{@p2.name} has won the game!"
      end
    end
  end

  def no_moves_left?
    if @turn_count == 10
      puts "The game ended in a tie."
      return true
    else
      return false
    end
  end

  def reset
  end

  def play_again
    puts "Would you like to go for anothere round?"
    print "y/n: "
    choice = gets.chomp
    if choice.upcase == "Y" || choice.upcase == "YES"
      system 'clear'
      puts "Thanks for playing!"
      return true
    else
      return false
    end
  end

  def get_name player
    print "#{player}, choose your name: "
    name = gets.chomp
    puts "You have chosen #{name} as your name"
    name
  end

  def get_symbol
    print "Now, choose your symbol: "
    symbol = gets.chomp
    puts "You have chosen #{symbol} as your symbol"
    symbol
  end
end