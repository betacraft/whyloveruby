class ChangeLetterDescriptionColumnType < ActiveRecord::Migration
  def up
    change_column :letters, :description, :text
  end

  def down
    change_column :letters, :description, :string
  end
end
