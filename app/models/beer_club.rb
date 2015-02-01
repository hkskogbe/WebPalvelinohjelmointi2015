class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :membership

end
