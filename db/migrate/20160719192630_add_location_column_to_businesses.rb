class AddLocationColumnToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :location, :point
    remove_column :businesses, :coordinates
  end
end
