class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { in: 3..15 }

  validates :password, length: { minimum: 4 }

  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,  message: "has to contain one number and one upper case letter" }

  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  
  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
	beers.max { |a, b| a.average_rating <=> b.average_rating }.style	
  end

  def favorite_brewery
	return nil if ratings.empty?

	best_brewery = nil

	beers.each do |beer|
	  if best_brewery == nil
		best_brewery = beer.brewery
	  else
	    if beer.brewery.average_rating > best_brewery.average_rating
		  best_brewery=beer.brewery		
		end  
	  end
	end

	return best_brewery
#byebug
#	breweries.sort_by(average_rating).last

	#breweries.max { |a, b| a.average_rating <=> b.average_rating }
  end
end
