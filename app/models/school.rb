class School < ApplicationRecord
  validates :name, presence: true
  validates :street_name, presence: true
  validates :street_number, presence: true
  validates :zip_code, presence: true
  validates :parish, presence: true
  validates :city, presence: true
  validates :phone_number, presence: true

  geocoded_by :address
  after_validation :geocode, if: ->(school) {
    school.street_name_changed? or
    school.street_number_changed? or
    school.zip_code_changed? or
    school.parish_changed? or
    school.city_changed?
  }

  def address
    "#{street_name} #{street_number} #{apartment_number}, #{zip_code}, #{parish}, #{city}"
  end
end
