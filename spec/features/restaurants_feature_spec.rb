require 'rails_helper'

feature 'restaurants' do  
  
  context 'no restaurants have been added' do
    
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content('no restaurants added yet')
      expect(page).to have_link ('Add a restaurant')
    end
  end

  context 'restaurants have been added' do
    
    before  do
      Restaurant.create(name: 'KFC')
    end
    
    scenario 'adding a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'no restaurants added yet'
    end
  end
  
  context 'User can create a new restaurant' do
    
    scenario 'prompts the user to fill out a form, then displays the restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: "KFC"
      click_button 'Create Restaurant'
      expect(page).to have_content "KFC"
      expect(current_path).to eq '/restaurants'
    end
  end
  
  context 'Viewing restaurants' do
    
    let!(:kfc) {Restaurant.create(name: 'KFC')}
    
    scenario 'User can see restaurant\'s details' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end
  
  

end
