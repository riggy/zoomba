module Zoomba
  class Base < OpenStruct
    def self.perform_request(action, data = {})
      response = Net::HTTP.start(resource_uri(action).host,
                                 resource_uri(action).port,
                                 use_ssl: true) do |http|
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(Zoomba.configuration.to_h.merge(data))
        http.request(request)
      end

      process_response(response)
    end

    def self.process_response(response)
      if response.code == '200'
        parsed = JSON.parse(response.body)
        return parsed if parsed['error'].nil?
        raise Error::ApiError.new(parsed['error']['message'],
                                  parsed['error']['code'])
      end
    end

    def self.resource_path_part
      part = to_s.downcase.sub('zoomba::', '')
      raise 'Zoomba::Base needs to be inherited from' if part.nil? || part.empty?
      part
    end

    def resource_path_part
      self.class.resource_path_part
    end

    def resource_uri(action)
      @uri ||= URI("#{Zoomba.configuration.api_base_url}/#{resource_path_part}/#{action}")
    end
  end
end
