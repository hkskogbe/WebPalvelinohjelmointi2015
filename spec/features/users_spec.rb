 require 'rails_helper'

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'Foobar1')
      click_button('Log in')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

	it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      fill_in('username', with:'Pekka')
      fill_in('password', with:'wrong')
      click_button('Log in')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "user page shows correctly" do
	let!(:user1) { FactoryGirl.create :user, username:"Kappa" }
    let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:brewery2) { FactoryGirl.create :brewery, name:"Malmgard" }
    let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
    let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery2 }
	let!(:beer3) { FactoryGirl.create :beer, name:"Karhu2", brewery:brewery2 }
	let!(:rating1) { FactoryGirl.create :rating, score:9, beer:beer1, user:user1 }
  	let!(:rating2) { FactoryGirl.create :rating, score:10, beer:beer1, user:user1 }
	let!(:rating3) { FactoryGirl.create :rating, score:12, beer:beer2, user:user1  }  
    
	before :each do
      visit signin_path
      fill_in('username', with:'Kappa')
      fill_in('password', with:'Foobar1')
      click_button('Log in')
    end

	it "when user has a favorite style" do
	  visit user_path(user1)
	  expect(page).to have_content 'Favorite style: Lager'	
	end

	it "when user has a favorite brewery" do
	  visit user_path(user1)
	  expect(page).to have_content 'Favorite brewery: Malmgard'	
	end

  end

end
