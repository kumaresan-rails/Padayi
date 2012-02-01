class AddPasswordAndPasswordConfirmationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :password, :string
    add_column :users, :password_confirmation, :string
  end

  def self.down
    remove_column :users, :password_confirmation
    remove_column :users, :password
  end
end
