class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.references :user
      t.string :title
      t.datetime :end_date

      t.timestamps
    end
    add_index :contests, :user_id
  end
end
