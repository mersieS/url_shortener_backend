require 'faraday'
require 'json'

class RequestService
  DEFAULT_HEADERS = {
    'Content-Type' => 'application/json',
    'Accept' => 'application/json'
  }.freeze

  def initialize(base_url, headers = {})
    @headers = DEFAULT_HEADERS.merge(headers)
    @base_url = base_url
    @connection = Faraday.new(url: @base_url) do |conn|
      conn.request :url_encoded
      conn.response :logger
      conn.response :json, parser_options: { symbolize_names: true }
      conn.adapter Faraday.default_adapter
    end
  end

  def get(endpoint, params = {}, headers = {})
    response = @connection.get(endpoint) do |req|
      req.params = params
      set_headers(req, headers)
    end
    handle_response(response)
  end

  def post(endpoint, body = {}, headers = {})
    response = @connection.post(endpoint) do |req|
      req.body = body.to_json
      set_headers(req, headers)
    end
    handle_response(response)
  end

  def put(endpoint, body = {}, headers = {})
    response = @connection.put(endpoint) do |req|
      req.body = body.to_json
      set_headers(req, headers)
    end
    handle_response(response)
  end

  def delete(endpoint, params = {}, headers = {})
    response = @connection.delete(endpoint) do |req|
      req.params = params
      set_headers(req, headers)
    end
    handle_response(response)
  end

  private

  def set_headers(request, headers)
    merged_headers = @headers.merge(headers)
    merged_headers.each do |key, value|
      request.headers[key] = value
    end
  end

  def handle_response(response)
    case response.status
    when 200..299
      response.body
    else
      raise "Error: #{response.status} - #{response.body[:message] || 'Unknown error'}"
    end
  end
end