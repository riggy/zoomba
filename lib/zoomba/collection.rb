module Zoomba
  # Defines a collection of Zoom resources
  # TODO add methods
  class Collection < Array
    def initialize(api_response, type = nil)
      super(api_response[type.to_s].map { |u| Zoomba::User.new(u) })
    end
  end
end
