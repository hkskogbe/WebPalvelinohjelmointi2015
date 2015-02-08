 require 'rails_helper'

describe "Beers" do
  let!(:user) { FactoryGirl.create :user }

  before :each do
    visit signin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  it "can be added to DB if name is valid" do
    visit new_beer_path

	fill_in('beer_name', with:'Pekka')
    click_button('Create Beer')

    expect(page).to have_content 'successfully created'
  end

  it "return user to beer creation page and show correct error message if name not valid" do
	visit new_beer_path

	fill_in('beer_name', with:'')
	click_button('Create Beer')

	expect(page).to have_content "Name can't be blank"
	expect(Beer.count).to eq(0)
  end




end






