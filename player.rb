class Player
  attr_reader :owned_tiles
  attr_reader :name
  attr_reader :symbol

  def initialize name, symbol
    @owned_tiles = []
    @name = name
    if symbol.is_number?
      @symbol = 'X'
    elsif symbol.length == 1
      @symbol = symbol.upcase
    else
      @symbol = 'X'
    end
  end

  def acquire_tile tile
    @owned_tiles << tile
  end
end

class Object
  def is_number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end