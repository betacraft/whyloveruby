class AddTwitterFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :twitter_oauth, :string
    add_column :users, :twitter_handle, :string
    add_column :users, :twitter_description, :string
    add_column :users, :website, :string

  end
end
