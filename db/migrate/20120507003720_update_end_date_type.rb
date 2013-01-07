class UpdateEndDateType < ActiveRecord::Migration
  def up
    remove_column :contests, :end_date
    add_column :contests, :end_date,    :datetime
  end

  def down
  end
end
