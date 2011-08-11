class AddNameToBusiness < ActiveRecord::Migration
  def self.up
    add_column :businesses, :name, :string
  end

  def self.down
    remove_column :businesses, :name
  end
end
