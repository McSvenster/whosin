class CreateProjekts < ActiveRecord::Migration
  def change
    create_table :projekts do |t|
      t.string :title
      t.string :description
      t.string :jpissue
      t.date :startdate
      t.date :enddate

      t.timestamps null: false
    end
  end
end
