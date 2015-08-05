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

  scenario 'can input firing coordinates' do 
    fill_in "coordinates", with: :B4
  end
end