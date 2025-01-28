module Postgis
  extend ActiveSupport::Concern

  # The code inside the included block is evaluated
  # in the context of the class that includes the Visible concern.
  # You can write class macros here, and
  # any methods become instance methods of the including class.
  class_methods do
    def g_within_polygon(points)
      points = GeoGis.pairs_to_points(points)
      polygon = GeoGis.polygon(points)
      where("ST_Covers(:polygon, g_coords)", polygon: GeoGis.to_wkt(polygon))
    end
  end
end
