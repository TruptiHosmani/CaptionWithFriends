class CreateContestants < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.references :contest
      t.references :user

      t.timestamps
    end
    add_index :contestants, :contest_id
    add_index :contestants, :user_id
  end
end
