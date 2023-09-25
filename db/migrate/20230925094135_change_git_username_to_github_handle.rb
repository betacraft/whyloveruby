class ChangeGitUsernameToGithubHandle < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :git_username, :github_handle
  end
end
