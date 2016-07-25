class CreateRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :recommendations do |t|
      t.references :business
      t.references :user, foreign_key: true
      t.boolean      :value

      t.timestamps
    end
    add_column :businesses, :is_local, :boolean
  end
end
