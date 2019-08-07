class CreateLetters < ActiveRecord::Migration[5.2]
  def change
    create_table :letters do |t|
      t.string :description
      t.references :user

      t.timestamps
    end
  end
end
