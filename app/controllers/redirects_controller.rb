class RedirectsController < ApplicationController
  def redirect
    @url = Url.find_by(short_url: params[:short_url])
    if @url
      @click = @url.clicks.create(
        ip_address: request.remote_ip,
        browser: request.user_agent
      )

      service = IpApi::GetLocation.new(click: @click)
      data = service.execute

      @click.country = get_country(data)
      @click.city = get_city(data)
      @click.save

      redirect_to @url.original_url, allow_other_host: true
    else
      render json: { error: "URL not found" }, status: :not_found
    end
  end

  private

  def get_country(data)
    data[:country] ||= ""
  end

  def get_city(data)
    data[:city] ||= ""
  end
end
