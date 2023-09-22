class AddGithubFieldToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :git_username, :string
  end
end
