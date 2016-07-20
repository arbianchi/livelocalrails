class AddNullConstraintToColumnsOnUser < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :zip_code, false
    change_column_null :users, :username, false
  end
end
