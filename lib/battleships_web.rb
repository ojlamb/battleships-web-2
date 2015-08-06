require 'sinatra/base'
require 'battleships'
require 'grid_builder'

class BattleshipsWeb < Sinatra::Base
  include Gridbuilder

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
    erb :game_page
  end

  set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0

  post '/fire_shot' do
    @name = $game.player_1.name
    coordinates = (params[:coordinates]).upcase.to_sym
    @hit = true if ($game.player_1.shoot coordinates) == :hit
    erb :game_page
  end

  def initialize_game
    game = Game.new Player, Board
    game.player_1.name = @name
    game
  end

  def randomly_place_ships player
    ship_types = [:submarine, :destroyer, :cruiser, :battleship, :aircraft_carrier]
    available_coordinates = build_grid
  end

end
