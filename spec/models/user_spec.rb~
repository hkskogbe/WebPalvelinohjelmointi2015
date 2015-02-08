require 'rails_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "is not saved in DB when it" do
	it "has too short password" do
	  user = User.create username:"Pekka", password:"aA1", password_confirmation:"aA1"

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
	end    
	
	it "has password that consists only of lower case letters" do
	  user = User.create username:"Pekka", password:"salasanaykkonen", password_confirmation:"salasanaykkonen"

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
	end    
	
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
  

    it "is the only rated if only one rating" do
        beer = FactoryGirl.create(:beer)
        rating = FactoryGirl.create(:rating, beer:beer, user:user)
  
        expect(user.favorite_beer).to eq(beer)
    end
  
    it "is the one with highest rating if several rated" do
      create_beer_with_rating(10, user)
      best = create_beer_with_rating(25, user)
      create_beer_with_rating(7, user)

      expect(user.favorite_beer).to eq(best)
    end
  end


  describe "favorite style" do
	let(:user){FactoryGirl.create(:user) }

	it "has method for determining one" do
	  user.should respond_to :favorite_style	
	end  

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

	it "is the only rated if only one rating" do
        beer = FactoryGirl.create(:beer)
        rating = FactoryGirl.create(:rating, beer:beer, user:user)

        expect(user.favorite_style).to eq(beer.style)
    end

	it "is the one with highest average rating if several rated" do

	  a = Beer.create name:"asd", style:"a"
	  b = Beer.create name:"wasd", style:"b"
	  c = Beer.create name:"dasd", style:"c"
	  
      a.ratings.create score:1, user:user
      a.ratings.create score:20, user:user
      b.ratings.create score:6, user:user
      c.ratings.create score:17, user:user

      expect(user.favorite_style).to eq("c")
    end


  end

  describe "favorite brewery" do
  	let(:user){FactoryGirl.create(:user) }
	let(:brewery){FactoryGirl.create(:brewery) }

  	it "has method for determining one" do
	  user.should respond_to :favorite_brewery	
	end  

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

	it "is the only rated if only one rating" do
        beer = FactoryGirl.create(:beer, brewery:brewery)
        rating = FactoryGirl.create(:rating, beer:beer, user:user)

        expect(user.favorite_brewery).to eq(brewery)
    end

	it "is the one with highest average rating if several rated" do

	  brewery2 = Brewery.create name:"kaksi", year:"2002"
	  brewery3 = Brewery.create name:"kolme", year:"2003"

	  a = Beer.create name:"asd", brewery:brewery2, style:"Lager"
	  b = Beer.create name:"wasd", brewery:brewery3, style:"Lager"
	  c = Beer.create name:"dasd", brewery:brewery, style:"Lager"
	  
      a.ratings.create score:1, user:user
      a.ratings.create score:20, user:user
      b.ratings.create score:6, user:user
      b.ratings.create score:22, user:user
      c.ratings.create score:10, user:user


      expect(user.favorite_brewery).to eq(brewery3)
    end


  end


  
  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end

  
end end
