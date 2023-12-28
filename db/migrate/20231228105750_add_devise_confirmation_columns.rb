class AddDeviseConfirmationColumns < ActiveRecord::Migration[6.1]
  def change
    # Confirmable columns
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string

    add_index :users, :confirmation_token, unique: true

    User.update_all confirmed_at: DateTime.now
  end
end
