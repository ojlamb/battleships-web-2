module Gridbuilder
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