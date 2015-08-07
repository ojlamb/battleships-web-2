require 'sinatra/base'
require 'battleships'
require_relative 'game'
require_relative 'random_ships.rb'

class BattleshipsWeb < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  post '/game_page' do
    if params[:name] == ""
      @name = "Player1"
    else
      @name = params[:name]
    end
    $game = initialize_game
    $game.player_1.name = @name
    # $game.player_2.place_ship(Ship.cruiser, :A1)
    erb :game_page
  end

  # get '/set_board' do
  #   erb :set_board
  # end

  # post '/set_board' do
  #   if params[:name] == ""
  #     @name = "Player1"
  #   else
  #     @name = params[:name]
  #   end
  #   $game = initialize_game
  #   erb :set_board
  # end

  set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0

  post '/fire_shot' do
    @name = $game.player_1.name
    coordinates = (params[:coordinates]).upcase.to_sym
    shotspot = $game.player_1.shoot coordinates
    p shotspot
    if shotspot == :hit
      @hit = true
    elsif shotspot == :sunk
      @hit = true
      @sunk = true
    else
      @hit = false
    end
    erb :game_page
  end

  def initialize_game
    game = Game.new Player, Board
    game.player_1.name = @name
    game
  end

end
