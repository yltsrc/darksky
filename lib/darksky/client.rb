module Darksky
  class Client
    class ServerError < StandardError; end
    URL = "https://api.darksky.net"

    def initialize(api_secret_key)
      @api_secret_key = api_secret_key
    end

    def forecast(lat, lng, params = {})
      time_machine(lat, lng, nil, params)
    end

    def time_machine(lat, lng, unix_time, params = {})
      attrs = [lat, lng, unix_time].compact.join(',')
      uri = URI("#{URL}/forecast/#{@api_secret_key}/#{attrs}")
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        raise Darksky::Client::ServerError, response.inspect
      end
    end
  end
end
