class AddPicContests < ActiveRecord::Migration
  def up
    add_column :contests, :pic_file_name,    :string
    add_column :contests, :pic_content_type, :string
    add_column :contests, :pic_file_size,    :integer
    add_column :contests, :pic_updated_at,   :datetime
  end

  def down
  end
end
