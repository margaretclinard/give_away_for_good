class AddTwitterColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_uid, :string
    add_column :users, :twitter_nickname, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_secret, :string
  end
end
