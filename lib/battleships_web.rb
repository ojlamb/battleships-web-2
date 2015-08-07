require 'sinatra/base'
require 'battleships'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  post '/game_page' do
    # if params[:name] == ""
    #   @name = "Player1"
    # else
    #   @name = params[:name]
    # end
    $game.player_1.name = @name
    $game.player_2.place_ship(Ship.cruiser, :A1)
    erb :game_page
  end

  get '/set_board' do
    erb :set_board
  end

  post '/set_board' do
    if params[:name] == ""
      @name = "Player1"
    else
      @name = params[:name]
    end
    $game = initialize_game
    erb :set_board
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

end
