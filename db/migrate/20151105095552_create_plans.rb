class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :jahr
      t.date :start_datum
      t.date :end_datum
      t.string :wochentage
      t.string :attendees
      t.string :folge
      t.boolean :abgenommen

      t.timestamps null: false
    end
  end
end
