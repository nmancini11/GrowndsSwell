class AddAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :gender, :string
  end

  def self.down
    remove_column :users, :gender
    remove_column :users, :name
    remove_column :users, :username
  end
end
