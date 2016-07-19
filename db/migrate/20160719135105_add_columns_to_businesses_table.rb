class AddColumnsToBusinessesTable < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore"
    add_column :businesses, :name, :string
    add_column :businesses, :address, :string
    add_column :businesses, :city, :string
    add_column :businesses, :zipcode, :string
    add_column :businesses, :phone, :string
    add_column :businesses, :coordinates, :hstore, default: {}, null: false
    add_column :businesses, :image_url, :string
    add_column :businesses, :website_url, :string
  end
end
