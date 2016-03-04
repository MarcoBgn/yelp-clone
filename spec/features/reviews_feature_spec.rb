feature 'Reviews' do
  before(:each) do
     Restaurant.create name: 'KFC' 
     sign_up
  end
 
  context 'Adding reviews' do 
    scenario 'a user can add a review' do
      visit '/restaurants'
      create_review
      expect(page).to have_content "Review submitted"
      click_link 'KFC'
      expect(page).to have_content "So so, ★★★"
    end
    
    scenario 'Users can only add one review per restaurant' do
      create_review
      create_review("average", 3)
      expect(page).to have_content "Restaurant already reviewed"
      expect(Review.all.count).to eq 1
      end
  end

  context 'Average rating' do
    scenario 'is calculated and displayed' do
      create_review('terrible', 1)
      click_link "Sign Out"
      sign_up('test2@ymail.com', 'secretpass', 'secretpass')
      create_review('good', 5)
      expect(page).to have_content "Average Rating: ★★★"
    end
  end
end

