class CreateEverything < ActiveRecord::Migration
  def up

    create_table :muscles do |t|
      t.column :name, :text
      t.column :muscle_group_id, :int
    end

    create_table :equipment do |t|
      t.column :name, :text
    end

    create_table :exercises do |t|
      t.column :name, :text
      t.column :target_muscle_id, :int
      t.column :equipment_id, :int
      t.column :link, :text
      t.column :multiplier, :smallint
    end

    create_table :workouts do |t|
      t.column :created_at, :timestamp
      t.column :muscle_groups, :'muscle_group[]'
    end

    create_table :workout_sets do |t|
      t.column :created_at, :timestamp
      t.column :workout_id, :int
      t.column :exercise_id, :int
      t.column :reps, :'int[]'
      t.column :weights, :'numeric[]'
      t.column :notes, :text
    end
  end

  def down
  end
end
