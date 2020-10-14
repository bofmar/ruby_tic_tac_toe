# Used for testing for now

require_relative 'grid'
require_relative 'player'

#grid = Grid.new
player = Player.new "Mario", "M"

player.acquire_tile "1"
p player.name
p player.owned_tiles
p player.symbol

