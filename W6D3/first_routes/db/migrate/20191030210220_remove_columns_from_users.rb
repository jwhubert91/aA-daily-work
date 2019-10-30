class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :email
    remove_column :users, :name
    
    add_column :users, :username, :string
  end
end
