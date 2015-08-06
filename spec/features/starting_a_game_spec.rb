require 'spec_helper'

feature 'Starting a new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_field("name")
  end

  context 'When I enter my name' do
    scenario 'I am taken to the game page' do
    visit '/new_game'
    fill_in('name', with: 'Andy')
    click_button('Submit')
    expect(page).to have_content("Hello, Andy! Let the games begin!")
  end
end

  context 'when user does not enter name' do
    scenario "user is given name 'Player1'" do
      visit '/new_game'
      click_button('Submit')
      expect(page).to have_content("Hello, Player1! Let the games begin!")
    end
  end

end
