module Randomships
  def randomly_place_ships game
    ship_types = [:submarine, :destroyer, :cruiser, :battleship, :aircraft_carrier]
    available_coordinates = build_grid

    until game.player_2.board.ships.count == 5 do
      begin
        ship_type = ship_types.first
        random_coordinate = available_coordinates.sample
        random_orientation = [:horizontally, :vertically].sample
        ship = create_ship(ship_type)

        game.player_2.place_ship(ship, random_coordinate, random_orientation)

        ship_types.shift
        coordinate_index = available_coordinates.index{|i| i == random_coordinate}
        available_coordinates.slice!(coordinate_index)
        
      rescue RuntimeError
        retry
      end
    end

  end

  def create_ship ship_type
    return Ship.submarine         if ship_type == :submarine
    return Ship.destroyer         if ship_type == :destroyer
    return Ship.cruiser           if ship_type == :cruiser
    return Ship.battleship        if ship_type == :battleship
    return Ship.aircraft_carrier  if ship_type == :aircraft_carrier
  end

  def build_grid
    grid = []
    letters = []

    letter = "A"
    Board::SIZE.times do
      letters << letter
      letter = letter.next
    end

    letters.each do |letter|
      x = 1
      Board::SIZE.times do 
        grid << ((letter + x.to_s).to_sym)
        x += 1
      end
    end
    grid
  end

end