class ClicksReportSerializer
  attr_reader :report_data
  def initialize(report_data)
    @report = report_data
  end

  def serialize
    {
      totalClicks: @report.total_clicks,
      averageDailyClicks: @report.average_daily_clicks,
      geo_stats: @report.geo_stats.map do |geo_stat|
        GeoStatsSerializer.new(geo_stat).as_json
      end
    }
  end
end
