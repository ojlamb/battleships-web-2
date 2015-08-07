require 'sinatra/base'
require 'battleships'
require_relative 'game'
require_relative 'random_ships.rb'

class BattleshipsWeb < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  get '/new_game' do
    erb :new_game
  end

  post '/game_page' do
    # @current_player = session["current_player"]
    if params[:name] == ""
      if session["current_player"] == nil
        @player1 = "Player1"
        session["current_player"] = "Player1"
      else
        @player2 = "Player2"
        session["current_player"] = "Player2"
      end
      p session["current_player"]
    else
      @name = params[:name]
      if session["current_player"] == nil
        @player1 = @name
        session["current_player"] = @name
      else
        @player2 = @name
        session["current_player"] = @name
      end
      p session["current_player"]
    end
    $game ? $game : $game = initialize_game
    $game.player_1.name = @name
    erb :game_page
  end

  set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0

  post '/fire_shot' do
    @name = $game.player_1.name
    coordinates = (params[:coordinates]).upcase.to_sym
    begin
    shotspot = $game.player_1.shoot coordinates
      if shotspot == :hit
        @hit = true
      elsif shotspot == :sunk
        @hit = true
        @sunk = true
      else
        @hit = false
      end
    rescue
      @already_shot_there = true
    end
    switch_players
    p session["current_player"]
    erb :game_page
  end

  def initialize_game
    game = Game.new Player, Board
    game.player_1.name = @name
    game
  end

  def switch_players
    @name = session["current_player"].freeze
    if @name == @player1
      session["current_player"] = @player2
    elsif @current_player == @player2
      session["current_player"] = @player1
    else
      session["current_player"] = @player1
    end
  end

end
