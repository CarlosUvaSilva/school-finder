class School < ApplicationRecord
  include PgSearch::Model
  include Postgis

  validates :name, presence: true
  validates :street_name, presence: true
  validates :street_number, presence: true
  validates :zip_code, presence: true
  validates :parish, presence: true
  validates :city, presence: true
  validates :phone_number, presence: true

  has_many :school_education_levels, dependent: :destroy
  has_many :education_levels, through: :school_education_levels

  geocoded_by :address
  after_validation :geocode, if: ->(school) {
    school.street_name_changed? or
    school.street_number_changed? or
    school.zip_code_changed? or
    school.parish_changed? or
    school.city_changed?
  }

  pg_search_scope :search,
                  ignoring: :accents,
                  against: :search_vector,
                  using: {
                    tsearch: {
                      dictionary: "simple",
                      any_word: true,
                      prefix: true,
                      tsvector_column: "tsv_accented"
                    }
                  }

  def address
    street = [ street_name, street_number, apartment_number, parish ].compact.join(" ")
    "#{street}, #{zip_code}, #{city}"
  end

  def geocode
    super
    return unless latitude && longitude
    self.g_coords = GeoGis.point(longitude, latitude)
  end
end
