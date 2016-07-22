class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|

      t.integer :responder_id
      t.string :responder_type
      t.boolean :hiring
      t.boolean :glutFree
      t.boolean :musicians
      t.boolean :lgbt
      t.boolean :localFood
      t.boolean :minorityOwned
      t.boolean :livWage
      t.boolean :petFriend
      t.boolean :artsCrafts
      t.boolean :charNonprof
      t.boolean :sustain
      t.boolean :veganPeta

      t.timestamps

      # add_index :surveys, [:responder_type, :responder_id]

    end
  end
end
