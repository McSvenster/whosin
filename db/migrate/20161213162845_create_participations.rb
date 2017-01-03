class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :milestone_id
      t.integer :user_id
      t.date :startdate
      t.date :enddate
      t.integer :attention

      t.timestamps null: false
    end
  end
end
