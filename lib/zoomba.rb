require 'net/http'
require 'json'
require 'ostruct'

require 'zoomba/error'
require 'zoomba/base'
require 'zoomba/collection'
require 'zoomba/configuration'
require 'zoomba/user'
require 'zoomba/version'

module Zoomba
  class << self
    attr_reader :configuration

    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end

    def configuration
      if @configuration.nil? || !@configuration.complete?
        raise Zoomba::Error::NoConfiguration
      end
      @configuration
    end
  end
end
