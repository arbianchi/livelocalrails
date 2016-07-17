class AddOwnerIdToBusinessesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :owner_id, :integer
  end
end
