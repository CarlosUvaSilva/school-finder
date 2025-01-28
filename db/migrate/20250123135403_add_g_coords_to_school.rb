class AddGCoordsToSchool < ActiveRecord::Migration[8.0]
  def change
    add_column :schools, :g_coords, :st_point, geographic: true
    add_index :schools, :g_coords, using: :gist
  end
end
