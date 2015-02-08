require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved to DB if it has username and style set correctly" do
    beer = Beer.create name:"Pekka", style:"ihminen"

    expect(beer.name).to eq("Pekka")
	expect(beer.style).to eq("ihminen")
	
	expect(beer).to be_valid
	expect(Beer.count).to eq(1)
  end

  it "is not created without a name" do
	beer = Beer.create style:"tyhja"

	expect(beer).not_to be_valid
  end

  it "is not created without a style" do
	beer = Beer.create name:"tyyliton"

	expect(beer).not_to be_valid
  end

  describe "when one beer exists" do
    let(:beer){FactoryGirl.create(:beer)}

    it "is valid" do
      expect(beer).to be_valid
    end

    it "has the default style" do
      expect(beer.style).to eq("Lager")
    end
  end
end
