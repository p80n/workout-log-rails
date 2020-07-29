class AddWarmupBooleanToWorkoutSet < ActiveRecord::Migration[5.0]
  def change
    add_column :workout_sets, :warmup, :boolean
  end
end
