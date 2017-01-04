class AddPeakToParticipations < ActiveRecord::Migration[5.0]
  def change
    add_column :participations, :peak, :integer
  end
end
