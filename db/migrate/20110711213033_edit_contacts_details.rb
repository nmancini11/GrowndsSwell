class EditContactsDetails < ActiveRecord::Migration
  def self.up
    change_table :contacts do |t|
      t.rename :first_name, :name
    end
    remove_column :contacts, :last_name
  end

  def self.down
    change_table :contacts do |t|
      t.rename :name, :first_name
    end
    add_coumn :contacts, :last_name, :string
  end
end
