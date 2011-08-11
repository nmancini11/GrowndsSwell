class AddOauthTokenToAuthorizations < ActiveRecord::Migration
  def self.up
    add_column :authentications, :oauth_token, :string
  end

  def self.down
    remove_column :authentications, :oauth_token
  end
end
