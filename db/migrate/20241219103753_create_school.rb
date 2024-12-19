class CreateSchool < ActiveRecord::Migration[8.0]
  def change
    create_table :schools do |t|
      t.timestamps

      t.string :name, null: false
      t.string :street_name, null: false
      t.integer :street_number, null: false
      t.string :apartment_number
      t.string :zip_code, null: false
      t.string :parish, null: false
      t.string :city, null: false
      t.string :phone_number, null: false
      t.string :email
    end
  end
end
