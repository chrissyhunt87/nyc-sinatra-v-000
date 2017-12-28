class ChangeLandmarks < ActiveRecord::Migration
  def change
    change_table :landmarks do |t|
      t.remove :year_completed
      t.column :year_completed, :integer
    end
  end
end
