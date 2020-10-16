class COM < Player
  attr_accessor :dif_lvl
  attr_accessor :grid_copy

  def greeting name
    if @dif_lvl == "EASY"
      puts "WOPR says: HELLO PROFESSOR #{name.upcase}"
    elsif @dif_lvl == "NORMAL"
      puts "T-800 says: Don't play with me if you want to live."
    else
      puts "HAL-9000 says: I am afraid I can't let you win, #{name}."
    end
  end

  def gloat name
    if @dif_lvl == "EASY"
      puts "WOPR says: HELLO PROFESSOR #{name.upcase}"
      puts "WOPR says: SHALL WE PLAY ANOTHER GAME?"
    elsif @dif_lvl == "NORMAL"
      puts "T-800 says: Hasta la vista, baby"
    else
      puts "HAL-9000 says: I am sorry, #{name}. I am afraid I can't let you win."
    end
  end

  def lament name
    if @dif_lvl == "EASY"
      puts "WOPR says: HELLO PROFESSOR #{name.upcase}"
      puts "WOPR says: A STRANGE GAME."
      puts "WOPR says: THE ONLY WINNING MOVE IS NOT TO PLAY AGAINST YOU"
    elsif @dif_lvl == "NORMAL"
      puts "T-800 says: I'll be back"
    else
      puts "This should never hapen"
    end
  end

  def choose_move op_sym
    @op_sym = op_sym
    if dif_lvl == "EASY"
      return random_move
    elsif dif_lvl == "NORMAL"

      #try to win first
      move = 0
      move = try_win op_sym, @grid_copy
      unless move == 100
        return move
      end

      #then try to block oponent from winning
      move = try_block op_sym, @grid_copy
      unless move == 100
        return move
      end

      #otherwise go to a random spot
      return random_move
    else
      scores = [3,5,2,9,12,5,23,23]
      n = scores.length
      height = log2(n)
      result = minimax(0,0, true, scores, height)

      puts "The optimal value is: #{result}"
    end
  end

  def random_move
    go_on = true
    move = 0
    while go_on
      move = rand(9) + 1
      go_on = move_available?(move)
    end
    return move
  end

  def move_available? choice
    test_grid = @grid_copy.flatten
    if test_grid.include?(choice.to_s)
      return false
    else
      return true
    end
  end

  def try_win op_sym, arr
    #check rows
    for i in 0..2
      if arr[i][0] == arr[i][1] && arr[i][0] == @symbol && arr[i][2] != op_sym || arr[i][1] == arr[i][2] && arr[i][1] == @symbol && arr[i][0] != op_sym || arr[i][0] == arr[i][2] && arr[i][0] == @symbol && arr[i][1] != op_sym 
        if arr[i][0] != @symbol && arr[i][0] != op_sym
          return arr[i][0]
        elsif arr[i][1] != @symbol && arr[i][1] != op_sym
          return arr[i][1]
        else
          return arr[i][2]
        end
      end
    end

    #check columns
    for i in 0..2
      if arr[0][i] == arr[1][i] && arr[0][i] == @symbol && arr[2][i] != op_sym || arr[1][i] == arr[2][i] && arr[1][i] == @symbol && arr[0][i] != op_sym || arr[0][i] == arr[2][i] && arr[0][i] == @symbol && arr[1][i] != op_sym
        if arr[0][i] != @symbol && arr[0][i] != op_sym
          return arr[0][i]
        elsif arr[1][i] != @symbol && arr[1][i] != op_sym
          return arr[1][i]
        else
          return arr[2][i]
        end
      end
    end

    #check diagonals
    if arr[0][0] == arr[1][1] && arr[0][0] == @symbol && arr[2][2] != op_sym
      return arr[2][2]
    elsif arr[1][1] == arr[2][2] && arr[1][1] == @symbol && arr[0][0] != op_sym
      return arr[0][0]
    elsif arr[0][0] == arr[2][2] && arr[0][0] == @symbol && arr[1][1] != op_sym
      return arr[1][1]
    elsif arr[0][2] == arr[1][1] && arr[0][2] == @symbol && arr[2][0] != op_sym
      return arr[2][0]
    elsif arr[1][1] == arr[2][0] && arr[1][1] == @symbol && arr[0][2] != op_sym
      return arr[0][2]
    elsif arr[0][2] == arr[2][0] && arr[0][2] == @symbol && arr[1][1] != op_sym
      return arr[1][1]
    end

    return 100
  end

  def try_block op_sym, arr
    #check rows
    for i in 0..2
      if arr[i][0] == arr[i][1] && arr[i][0] == op_sym && arr[i][2] != @symbol || arr[i][1] == arr[i][2] && arr[i][1] == op_sym && arr[i][0] != @symbol || arr[i][0] == arr[i][2] && arr[i][0] == op_sym && arr[i][1] != @symbol 
        if arr[i][0] != @symbol && arr[i][0] != op_sym
          return arr[i][0]
        elsif arr[i][1] != @symbol && arr[i][1] != op_sym
          return arr[i][1]
        else
          return arr[i][2]
        end
      end
    end

    #check columns
    for i in 0..2
      if arr[0][i] == arr[1][i] && arr[0][i] == op_sym && arr[2][i] != @symbol || arr[1][i] == arr[2][i] && arr[1][i] == op_sym && arr[0][i] != @symbol || arr[0][i] == arr[2][i] && arr[0][i] == op_sym && arr[1][i] != @symbol
        if arr[0][i] != @symbol && arr[0][i] != op_sym
          return arr[0][i]
        elsif arr[1][i] != @symbol && arr[1][i] != op_sym 
          return arr[1][i]
        else
          return arr[2][i]
        end
      end
    end

    #check diagonals
    if arr[0][0] == arr[1][1] && arr[0][0] == op_sym && arr[2][2] != @symbol
      return arr[2][2]
    elsif arr[1][1] == arr[2][2] && arr[1][1] == op_sym && arr[0][0] != @symbol
      return arr[0][0]
    elsif arr[0][0] == arr[2][2] && arr[0][0] == op_sym && arr[1][1] != @symbol
      return arr[1][1]
    elsif arr[0][2] == arr[1][1] && arr[0][2] == op_sym && arr[2][0] != @symbol
      return arr[2][0]
    elsif arr[1][1] == arr[2][0] && arr[1][1] == op_sym && arr[0][2] != @symbol
      return arr[0][2]
    elsif arr[0][2] == arr[2][0] && arr[0][2] == op_sym && arr[1][1] != @symbol
      return arr[1][1]
    end

    return 100
  end

  def minimax depth, isMax
    score = evaluate_board

    if score == 10 || score == -10
      return score
    end

    unless is_moves_left
      return 0
    end

    if is_max

      best = -1000

      for i in 0..2
        for j in 0..2
          if @grid_copy[i][j] != @symbol && @grid_copy[i][j] != @op_sym
            placeholder = @grid_copy[i][j]
            @grid_copy[i][j] = @op_sym

            best = [best,minimax(depth + 1, !is_max)].max

            @grid_copy[i][j] = placeholder
          end
        end
      end
      return best
    else
      
      best = 1000
      for i in 0..2
        for j in 0..2
          if @grid_copy[i][j] != @symbol && @grid_copy[i][j] != @op_sym
            placeholder = @grid_copy[i][j]
            @grid_copy[i][j] = @op_sym

            best = [best,minimax(depth + 1, !is_max)].min

            @grid_copy[i][j] = placeholder
          end
        end
      end
      return best
    end
  end

  def find_best_move
  end

  def is_moves_left?
    for i in 0..2
      for j in 0..2
        if @grid_copy[i][j] != @symbol && @grid_copy != @op_sym
          return true
        end
    end
  end

  def evaluate_board
    #check rows
    for i in 0..2
      if @grid_copy[i][0] == @grid_copy[i][1] && @grid_copy[i][0] == @grid_copy[i][2]
        if @grid_copy[i][0] == @symbol
          return +10
        elsif @grid_copy[i][0] == @op_sym
          return -10
        end
      end
    end
    # check columns
    for i in 0..2
      if @grid_copy[0][i] == @grid_copy[1][i] && @grid_copy[0][i] == @grid_copy[2][i]
        if @grid_copy[0][i] == @symbol
          return +10
        elsif @grid_copy[0][i] == @op_sym
          return -10
        end
      end
    end

    #check diagonals
    if @grid_copy[0][0] == @grid_copy[1][1] && @grid_copy[1][1] == @grid_copy[2][2]
      if @grid_copy[0][0] == @symbol
        return 10
      elsif @grid_copy[0][0] == @op_sym
        return - 10
      end
    end

    if @grid_copy[0][2] == @grid_copy[1][1] && @grid_copy[1][1] == @grid[2][0]
      if @grid_copy[0][2] == @symbol
        return 10
      elsif @grid_copy[0][2] == @op_sym
        return - 10
    end

    return 0 # this hapens if no-one won
  end

end