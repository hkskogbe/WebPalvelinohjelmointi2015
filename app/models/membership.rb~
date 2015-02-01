class Membership < ActiveRecord::Base
    belongs_to :beer_club, dependent: :destroy
	belongs_to :user, dependent: :destroy
	
	validates :user_id, :uniqueness => {:scope=>:beer_club_id}
	
end
