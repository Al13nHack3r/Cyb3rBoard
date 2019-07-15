class AddIntelToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bio, :string
    add_column :users, :github, :string, allow_blank: true
    add_column :users, :discord, :string
    add_column :users, :web, :string
  end
end
