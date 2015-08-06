require 'spec_helper'

feature 'Playing a game' do
  before :each do
    visit '/'
    click_on 'New Game'
    click_on 'Submit'
  end

  context 'when new game starts' do
    scenario 'user sees firing coordinate text' do
      expect(page).to have_content("Enter firing coordinates!")
    end
  end

  scenario 'when new game starts, user should see a board' do
    expect(page).to have_content(
"    ABCDEFGHIJ
  ------------
 1|          |1
 2|          |2
 3|          |3
 4|          |4
 5|          |5
 6|          |6
 7|          |7
 8|          |8
 9|          |9
10|          |10
  ------------
   ABCDEFGHIJ")
 end
 context "when there is a ship on the board" do
   scenario 'and a shot hits' do
     $game.player_2.place_ship(Ship.cruiser, :B4)
     fill_in "coordinates", with: "b4"
     click_on "FIRE!"
     expect(page).to have_content 'HIT!!'
   end
 end
end

feature 'After game is initialized' do
  before :each do
    visit '/'
    click_on 'New Game'
    click_on 'Submit'
    $game = Game.new Player, Board
  end
  scenario "'HIT!' is printed to the screen" do
    allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:hit)
    fill_in "coordinates", with: "B4"
    click_on "FIRE!"
    expect(page).to have_content 'HIT!!'
  end

  context 'when user submits a coordinate in lowercase' do
    scenario "'HIT!' is printed to the screen" do
      allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:hit)
      fill_in "coordinates", with: "b4"
      click_on "FIRE!"
      expect(page).to have_content 'HIT!!'
    end
  end


  context "when there is a ship on the board" do
    scenario 'and a shot misses' do
      $game.player_2.place_ship(Ship.cruiser, :B4)
      fill_in "coordinates", with: "j4"
      click_on "FIRE!"
      expect(page).to have_content 'MISS!!'
    end
  end

  scenario 'Shots are displayed on the board' do
    $game.player_2.place_ship(Ship.cruiser, :A1)
    fill_in "coordinates", with: "A1"
    click_on "FIRE!"

    expect(page).to have_content(
    "    ABCDEFGHIJ
      ------------
     1|*         |1
     2|          |2
     3|          |3
     4|          |4
     5|          |5
     6|          |6
     7|          |7
     8|          |8
     9|          |9
    10|          |10
      ------------
       ABCDEFGHIJ")
    end
end
