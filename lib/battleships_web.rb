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
    if params[:name] == ""
      @name = "Player1"
    else
      @name = params[:name]
    end

    $game = initialize_game
    
    erb :game_page
  end

  set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0

  post '/fire_shot' do
    puts "from within fire_shot method: #{@game}"
    coordinates = (params[:coordinates]).upcase.to_sym
    $game.player_1.shoot coordinates
    @hit = true
    erb :game_page
  end

  def initialize_game
    game = Game.new Player, Board
    game.player_1.name = @name
    game
  end


end
