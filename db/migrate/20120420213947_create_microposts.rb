class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id
        t.decimal :rating_average, :precision => 3, :scale => 1, :default => nil

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]

  end
end
