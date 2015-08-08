require_relative 'random_ships.rb'

class Game
  include Randomships

  def initialize(playerClass, boardClass)
    @player_1 = initialize_player playerClass, boardClass
    @player_2 = initialize_player playerClass, boardClass


    player_1.opponent = player_2
    player_2.opponent = player_1

    randomly_place_ships self
    randomly_place_my_ships self
  end
end