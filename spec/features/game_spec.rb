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

    scenario 'user should see a board' do
      expect(page).to have_content(
      "  ABCDEFGHIJ")
    end

    scenario "user does NOT see 'MISS!!' on the screen" do
      expect(page).to_not have_content("MISS!!")
    end

    scenario "player_2's ships have all been randomly placed" do
      game = Game.new Player, Board
      expect(game.player_2.board.ships.count).to eq 5
    end
  end

  context "when a hit occurs" do
    before :each do
      allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:hit)
      fill_in "coordinates", with: "B4"
      click_on "FIRE!"
    end

    scenario "'HIT!' is printed to the screen" do
      expect(page).to have_content 'HIT!!'
    end

    scenario "'MISS!!' is NOT printed to the screen" do
      expect(page).to_not have_content 'MISS!!'
    end
  end

  scenario "when a hit occurs and the ship sinks" do
    allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:sunk)
    fill_in "coordinates", with: "B4"
    click_on "FIRE!"
    expect(page).to have_content 'Ship Sunk'
  end

  scenario "when firing at the same point twice" do
    2.times do
      fill_in "coordinates", with: "B4"
      click_on "FIRE!"
    end
    expect(page).to have_content 'ALREADY SHOT THERE'
  end

  context 'when user submits a successful coordinate in lowercase' do
    scenario "'HIT!' is printed to the screen" do
      allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:hit)
      fill_in "coordinates", with: "b4"
      click_on "FIRE!"
      expect(page).to have_content 'HIT!!'
    end
  end

  context "when a miss occurs" do
    before :each do
      allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:miss)
      fill_in "coordinates", with: "B4"
      click_on "FIRE!"
    end

    scenario "'MISS!!' is printed to the screen" do
      expect(page).to have_content 'MISS!!'
    end

    scenario "'HIT!!' is NOT printed to the screen" do
      expect(page).to_not have_content 'HIT!!'
    end
  end

end
