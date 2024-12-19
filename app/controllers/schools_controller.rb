class SchoolsController < ApplicationController
  def index
    @schools = School.all
    @markers = @schools.geocoded.map do |school|
      {
        lat: school.latitude,
        lng: school.longitude,
        marker_tooltip_html: render_to_string(partial: "marker_tooltip", locals: { school: school }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end
end
