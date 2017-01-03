class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :plan_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :attendances, [:plan_id, :user_id]
  end
end
