  ActiveAdmin.register User do

    index do
      column :id
      column :name
      column :last_sign_in_at
      column :created_at
      column :sign_in_count
      column :letters_count do |user|
        user.letters.count
      end
      column :external_identities
      column :likes do |user|
        user.likes.count
      end
      actions
    end

  end
