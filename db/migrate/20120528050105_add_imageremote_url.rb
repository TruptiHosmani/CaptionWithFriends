class AddImageremoteUrl < ActiveRecord::Migration
  def self.up
    add_column :contests, :image_remote_url, :string
  end

  def self.down
    remove_column :contests, :image_remote_url
  end
end
