class AddKaderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :kader, :boolean
  end
end
