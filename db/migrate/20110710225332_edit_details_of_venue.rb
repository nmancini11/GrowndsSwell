class EditDetailsOfVenue < ActiveRecord::Migration
  def self.up
    change_table :venues do |t|
      t.rename :venue_schedule_id, :schedule
      t.rename :venue_business_id, :business_id
      t.rename :venue_contact_id, :contact_id
    end
  end

  def self.down
    change_table :venues do |t|
      t.rename :schedule, :venue_schedule_id
      t.rename :business_id, :venue_business_id
      t.rename :contact_id, :venue_contact_id
    end
  end
end
