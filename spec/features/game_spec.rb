require 'spec_helper'

feature 'Playing a game' do
  before :each do
    visit '/'
    click_on 'New Game'
    click_on 'Submit'
  end

  scenario 'when new game starts, user sees firing coordinate text' do 
    expect(page).to have_content("Enter firing coordinates!")
  end

  context "when a hit occurs" do
    scenario "'HIT!' is printed to the screen" do
      game = Game.new Player, Board
      allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:hit)
      fill_in "coordinates", with: "B4"
      click_on "FIRE!"
      expect(page).to have_content 'HIT!!'
    end
  end

  context 'when user submits a coordinate in lowercase' do 

  end

end