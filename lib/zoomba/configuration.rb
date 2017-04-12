module Zoomba
  # Stores Zoomba configuration
  class Configuration
    attr_accessor :api_key, :api_secret, :api_base_url

    def initialize
      @api_base_url = 'https://api.zoom.us/v1'
    end

    def complete?
      !@api_key.nil? && !@api_secret.nil?
    end

    def to_h
      {
        api_key: @api_key,
        api_secret: @api_secret
      }
    end
  end
end
