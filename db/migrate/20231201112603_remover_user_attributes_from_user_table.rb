class RemoverUserAttributesFromUserTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :uid, :string
    remove_column :users, :provider, :string
    remove_column :users, :twitter_oauth, :string
    remove_column :users, :twitter_handle, :string
    remove_column :users, :twitter_description, :string
    remove_column :users, :website, :string
    remove_column :users, :image, :string
  end
end
