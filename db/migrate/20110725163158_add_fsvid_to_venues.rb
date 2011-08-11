class AddFsvidToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :fsvid, :string
  end

  def self.down
    remove_column :venues, :fsvid
  end
end
