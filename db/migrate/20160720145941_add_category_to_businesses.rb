class AddCategoryToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :categories, :string
  end
end
