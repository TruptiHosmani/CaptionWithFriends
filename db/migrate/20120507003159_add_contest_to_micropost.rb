class AddContestToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :contest_id, :integer
  end
end
