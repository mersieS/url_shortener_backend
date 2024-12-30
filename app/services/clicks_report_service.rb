require 'ostruct'

class ClicksReportService
  def initialize(url)
    @url = url
    @clicks = @url.clicks
  end

  def generate_report
    {
      total_clicks: total_clicks,
      average_daily_clicks: average_daily_clicks,
      geo_stats: geo_stats
    }
  end

  private

  def total_clicks
    @clicks.count
  end

  def average_daily_clicks
    days = @clicks.distinct.pluck(:created_at).map(&:to_date).uniq.size
    (total_clicks.to_f / days).round(2)
  end

  def geo_stats
    @clicks.select(:country)
           .group(:country)
           .select(Arel.sql('AVG(latitude) as avg_latitude'), Arel.sql('AVG(longitude) as avg_longitude'), Arel.sql('COUNT(*) as total_clicks'))
           .map do |click|
      {
        country: click.country,
        latitude: safe_round(click.avg_latitude),
        longitude: safe_round(click.avg_longitude),
        total_clicks: click.total_clicks,
        cities: city_stats(click.country)
      }
    end
  end

  def city_stats(country)
    @clicks.where(country: country)
           .group(:city)
           .select(:city, Arel.sql('COUNT(*) as clicks'))
           .map { |city| { name: city.city, clicks: city.clicks } }
  end

  # Güvenli round işlemi: Eğer değer nil ise, 0 döner
  def safe_round(value)
    value.nil? ? 0 : value.round(4)  # 4 ondalıklı değerle yuvarlama
  end
end
