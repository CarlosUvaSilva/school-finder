class SchoolEducationLevel < ApplicationRecord
  belongs_to :school
  belongs_to :education_level
end
