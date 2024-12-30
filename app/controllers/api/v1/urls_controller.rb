class Api::V1::UrlsController < Api::V1::AuthenticatedController
  def index
    @urls = current_user.urls

    if @urls.present?
      render json: { url: @urls }, status: :ok
    else
      render json: { errors: @urls }, status: :not_found
    end
  end

  def create
    @url = current_user.urls.build(url_params)
    if @url.save
      render json: { url: @url }, status: :ok
    else
      render json: { error: @url.errors.full_messages }, status: :internal_server_error
    end
  end

  def show
    @url = current_user.urls.find(params[:id])

    if @url.present?
      report_data = ClicksReportService.new(@url).generate_report
      report = ClicksReportSerializer.new(report_data).as_json
      render json: report, status: :ok
    else
      render json: { errors: @url.errors.full_messages }, status: :internal_server_error
    end
  end

  def clicks_per_day
    url = current_user.urls.find(params[:id])
    render json: format_clicks_data(url.clicks_grouped_by_day(date_range))
  end

  private

  def date_range
    30.days.ago.to_date..Time.current.to_date
  end


  def format_clicks_data(clicks_data)
    date_range.map do |date|
      {
        date: date.to_date,
        count: clicks_data[date.to_date] || 0
      }
    end
  end

  def url_params
    params.permit(:name, :original_url)
  end
end
