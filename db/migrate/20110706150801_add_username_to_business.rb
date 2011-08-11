class AddUsernameToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :username, :string
  end

  def self.down
    remove_column :businesses, :username
  end
end
