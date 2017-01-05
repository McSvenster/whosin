class CreatePeaks < ActiveRecord::Migration[5.0]
  def change
    create_table :peaks do |t|
      t.string :peaksign
      t.string :peakformula
      t.string :peakimage
      t.integer :participation_id

      t.timestamps
    end
  end
end
