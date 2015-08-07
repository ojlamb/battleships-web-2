  def build_grid
    grid = []
    letters = []

    letter = "A"
    10.times do
      letters << letter
      letter = letter.next
    end

    letters.each do |letter|
      x = 1
      10.times do 
        grid << ((letter + x.to_s).to_sym)
        x += 1
      end
    end
    grid
  end

  build_grid