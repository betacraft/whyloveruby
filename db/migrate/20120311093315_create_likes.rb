class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user
      t.references :letter

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :letter_id
  end
end
