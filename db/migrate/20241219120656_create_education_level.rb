class CreateEducationLevel < ActiveRecord::Migration[8.0]
  def change
    create_table :education_levels do |t|
      t.timestamps

      t.string :name, null: false
    end
  end
end
