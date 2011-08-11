class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :gender
      t.string :email_address

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
