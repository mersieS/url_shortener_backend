module GeoLocations
  class GetLocation
    attr_reader :click

    def initialize(click: nil)
      @click = click
    end

    def execute
      @service = ::RequestService.new(base_url)
      @response = @service.get(request_path(@click.ip_address.to_s))
    end

    private

    def base_url
      'http://ip-api.com/'
    end

    def request_path(ip_address)
      "json/#{ip_address}"
    end
  end
end