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
      "  ABCDEFGHIJ
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
  end

  context "when a hit occurs" do
    scenario "'HIT!' is printed to the screen" do
      allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:hit)
      fill_in "coordinates", with: "B4"
      click_on "FIRE!"
      expect(page).to have_content 'HIT!!'
    end
  end

  context 'when user submits a successful coordinate in lowercase' do
    scenario "'HIT!' is printed to the screen" do
      allow_any_instance_of(Board).to receive(:receive_shot).with(:B4).and_return(:hit)
      fill_in "coordinates", with: "b4"
      click_on "FIRE!"
      expect(page).to have_content 'HIT!!'
    end
  end

end
