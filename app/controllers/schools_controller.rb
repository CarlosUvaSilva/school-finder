class SchoolsController < ApplicationController
  def index
    @schools = School.includes(:education_levels).geocoded
    @markers = @schools.map do |school|
      {
        lat: school.latitude,
        lng: school.longitude,
        marker_tooltip_html: render_to_string(partial: "marker_tooltip", locals: { school: school }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end
end
