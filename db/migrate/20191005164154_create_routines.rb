class CreateRoutines < ActiveRecord::Migration[5.0]
  def change
    create_table :routines do |t|
      t.string :name
      t.string :link
      t.references :muscle_group, foreign_key: true

      t.timestamps
    end
  end
end
