class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :jahr
      t.date :start_datum
      t.date :end_datum
      t.string :wochentage, default: "1,2,3,4,5"
      t.integer :wechsel, default: 1
      t.text :folge
      t.boolean :abgenommen

      t.timestamps null: false
    end
  end
end
