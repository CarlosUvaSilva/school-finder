class SchoolsController < ApplicationController
  def index
    @schools = School.all.includes(:education_levels)
    if params[:search].present?
      search_query = params[:search]
      @schools = @schools.search(search_query).geocoded
    else
      @schools = @schools.geocoded
    end

    @markers = @schools.map do |school|
      {
        lat: school.latitude,
        lng: school.longitude,
        marker_tooltip_html: render_to_string(partial: "marker_tooltip", locals: { school: school }, formats: [ :html ]),
        marker_html: render_to_string(partial: "marker", formats: [ :html ])
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: { schools: @schools, markers: @markers } }
      format.turbo_stream
    end
  end
end
