require_relative 'grid'
require_relative 'player'
require_relative 'human'

class GM
  attr_reader :pvp

  def initialize
    @turn_count = 0
    @p1_turn = true
    @grid = Grid.new
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
    # TO DO
    # Add check for validity of move
    # Check for win before passing turn
    # Check for game over in the main (function in here will return a bool)
    if @pvp
      if @p1_turn
        puts "It's #{@p1.name}'s turn!"
        puts "#{@p1.name} choose a place in the grid to put your mark by inputing the co-responding number"
        choice = @p1.choose_move

        @grid.update_current_grid choice, @p1.symbol
        @p1_turn = false
      else
        puts "It's #{@p2.name}'s turn!"
        puts "#{@p2.name} choose a place in the grid to put your mark by inputing the co-responding number"
        choice = @p2.choose_move

        @grid.update_current_grid choice, @p2.symbol
        @p1_turn = true
      end
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