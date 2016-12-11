class RenameColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :activate_at, :activated_at
  end
end
