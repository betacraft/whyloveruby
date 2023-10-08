class RemoveUidAndProvidersFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :uid, :string
    remove_column :users, :provider, :string
    remove_column :users, :twitter_oauth, :string
    remove_column :users, :twitter_handle, :string
    remove_column :users, :twitter_description, :string
    remove_column :users, :github_handle, :string
    remove_column :users, :website, :string
    remove_column :users, :name, :string
    remove_column :users, :image, :string
    remove_column :users, :email, :string
  end
end
