class GeoStatsSerializer
  attr_reader :geo_stat

  def initialize(geo_stat)
    @geo_stat = geo_stat
  end

  def serialize
    {
      country: @geo_stat.country,
      latitude: @geo_stat.latitude,
      longitude: @geo_stat.longitude,
      totalClicks: @geo_stat.total_clicks,
      cities: @geo_stat.cities
    }
  end
end
