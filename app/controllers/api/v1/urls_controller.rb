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
    @url = current_user.url.find(params[:id])

    if @url.present?
      render json: { url: @url }, status: :ok
    else
      render json: { errors: @url.errors.full_messages }, status: :internal_server_error
    end
  end



  private

  def link_params
    params.permit(:name, :original_url)
  end

end
