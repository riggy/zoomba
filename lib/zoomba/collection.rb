
module Zoomba
  class Collection < Array
    def initialize(api_response, type = nil)
      puts api_response

      super(api_response[type.to_s].map { |u| Zoomba::User.new(u) })
    end
  end
end
