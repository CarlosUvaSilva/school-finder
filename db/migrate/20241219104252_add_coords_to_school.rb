class AddCoordsToSchool < ActiveRecord::Migration[8.0]
  def change
    add_column :schools, :latitude, :float
    add_column :schools, :longitude, :float

    add_index :schools, [ :latitude, :longitude ]
  end
end
