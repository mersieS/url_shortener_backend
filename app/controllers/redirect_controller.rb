class RedirectController < ApplicationController
  def redirect
    @url = Url.find_by(short_url: params[:short_url])
    if @url
      @url.clicks.create(
        ip_address: request.remote_ip,
        browser: request.user_agent
      )
      redirect_to @url.original_url
    else
      render plain: "URL not found", status: :not_found
    end
  end
end
