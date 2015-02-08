require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Pokko" }
  
  before :each do
    visit signin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows ratings and their amount on ratings page" do
	create_ratings

	visit ratings_path
	expect(page).to have_content 'Number of ratings: 4'
	expect(page).to have_content 'iso 3 10 Pekka'
  end

  it "shows only user's ratings on user's page" do
	create_ratings	

	visit user_path(user)
	expect(page).to have_content 'iso 3 10'
	expect(page).to have_content 'iso 3 10'
	expect(page).to have_content 'Karhu 12'
	expect(page).not_to have_content 'Karhu 5'
  end

  it "deletes rating from DB when user deletes a rating they have given" do
	create_ratings
	rating1 = Rating.find(1)
	visit user_path(user)
	find(:xpath, "(//a[text()='delete'])[1]").click
	
	expect(Rating.find_by(id:1)).to be_nil
	
  end

  def create_ratings
	FactoryGirl.create :rating, score:10, beer:beer1, user:user 
	FactoryGirl.create :rating, score:10, beer:beer1, user:user 
	FactoryGirl.create :rating, score:12, beer:beer2, user:user
	FactoryGirl.create :rating, score:5, beer:beer2, user:user2 
  end

end
