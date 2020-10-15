# Used for testing for now
require_relative 'game_master'

gm = GM.new

go_on = true
while go_on
  system "clear"
  gm.welcome
  mode_chosen = false

  until mode_chosen
    mode_chosen = gm.choose_mode
  end

  gm.get_players gm.pvp

  game = true
  while game
    gm.display_Grid
    game = gm.give_turn
  end

  gm.reset
  go_on = gm.play_again
end