class AddGithubFieldToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :github_handle, :string
  end
end
