class CreateJoinTableStyleBeer < ActiveRecord::Migration
  def change
    create_join_table :styles, :beers do |t|
      t.index [:style_id, :beer_id]
      t.index [:beer_id, :style_id]
    end
  end
end
