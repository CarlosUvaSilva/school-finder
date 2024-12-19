class School < ApplicationRecord
  validates :name, presence: true
  validates :street_name, presence: true
  validates :street_number, presence: true
  validates :zip_code, presence: true
  validates :parish, presence: true
  validates :city, presence: true
  validates :phone_number, presence: true
end
