class AddYelpIdToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :yelp_id, :string 
  end
end
