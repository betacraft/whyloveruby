class CreateExternalIdentities < ActiveRecord::Migration[6.1]
  def change
    create_table :external_identities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, null: false, default: ""
      t.string :uid, null: false, default: ""
      t.string :oauth, default: ""
      t.string :handle, default: ""
      t.string :description, default: ""
      t.string :website, default: ""
      t.string :name, default: ""
      t.string :email, default: ""
      t.string :image, default: ""
      t.timestamps
    end

    add_index :external_identities, [:user_id, :provider], unique: true
    add_index :external_identities, [:uid, :provider], unique: true
  end
end
