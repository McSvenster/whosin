class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :vname
      t.string :nname
      t.string :email
      t.string :blockdaten
      t.string :password_digest
      t.boolean :admin
      t.boolean :geloescht

      t.timestamps null: false
    end
  end
end
