class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, less_than_or_equal_to: 15 }
  #validates :password, length: { minimum: 4 }, format: { with: [A-Z], \d }

  has_secure_password
  has_many :ratings #monta ratingia/käyttäjä
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :membership
end