class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.integer :projekt_id
      t.string :title
      t.string :description
      t.date :startdate
      t.date :enddate

      t.timestamps null: false
    end
  end
end
