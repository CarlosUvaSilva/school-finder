class CreateSchoolEducationLevel < ActiveRecord::Migration[8.0]
  def change
    create_table :school_education_levels do |t|
      t.timestamps

      t.references :school, null: false, foreign_key: true
      t.references :education_level, null: false, foreign_key: true
    end

    add_index :school_education_levels, [ :school_id, :education_level_id ], unique: true
  end
end
