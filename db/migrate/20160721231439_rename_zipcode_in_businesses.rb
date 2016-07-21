class RenameZipcodeInBusinesses < ActiveRecord::Migration[5.0]
  def change
    rename_column :businesses, :zipcode, :zip_code
  end
end
