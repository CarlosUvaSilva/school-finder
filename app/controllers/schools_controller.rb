class SchoolsController < ApplicationController
  def index
    @schools = School.all.includes(:education_levels).geocoded

    if params[:search].present?
      search_query = params[:search]
      @schools = @schools.search(search_query)
    end

    if params[:polygon].present?
      coords = JSON.parse(params[:polygon])
      @schools = @schools.g_within_polygon(coords)
    end

    @markers = @schools.map do |school|
      {
        lat: school.latitude,
        lng: school.longitude,
        marker_tooltip_html: render_to_string(partial: "schools/marker_tooltip", locals: { school: school }, formats: [ :html ]),
        marker_html: render_to_string(partial: "schools/marker", locals: { school: school }, formats: [ :html ])
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: { schools: @schools, markers: @markers } }
      format.turbo_stream { render locals: { schools: @schools, markers: @markers } }
    end
  end
end
