class CreateExternalIdentities < ActiveRecord::Migration[6.1]
  def change
    create_table :external_identities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :oauth
      t.string :handle
      t.string :description
      t.string :website
      t.string :name
      t.string :email
      t.string :image
      t.timestamps
    end
  end
end
