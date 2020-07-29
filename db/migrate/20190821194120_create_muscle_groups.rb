class CreateMuscleGroups < ActiveRecord::Migration[5.0]
  def change

    create_table :muscle_groups do |t|
      t.column :name, :text
    end

    create_table :muscles do |t|
      t.column :name, :text
      t.column :muscle_group_id, :int
    end



  end
end
