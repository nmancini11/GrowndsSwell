class RemoveCheckIns < ActiveRecord::Migration
  def self.up
    drop_table :check_ins
  end

  def self.down
    create_table :check_ins
  end
end
