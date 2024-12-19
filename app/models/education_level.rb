class EducationLevel < ApplicationRecord
  validates :name, presence: true

  has_many :school_education_levels, dependent: :destroy
  has_many :sc, through: :school_education_levels
end
