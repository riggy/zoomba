module Zoomba
  class Base < OpenStruct
    def assign(args = {})
      args.each do |key, value|
        next if key.to_sym == :id
        send("#{key}=", value)
      end
      self
    end

    def self.perform_request(action, data = {})
      uri = URI("#{Zoomba.configuration.api_base_url}/#{resource_path_part}/#{action}")
      response = Net::HTTP.start(uri.host,
                                 uri.port,
                                 use_ssl: true) do |http|
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(Zoomba.configuration.to_h.merge(data))
        http.request(request)
      end

      process_response(response)
    end

    def perform_request(action, data = {})
      self.class.perform_request(action, data)
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
      to_s.downcase.sub('zoomba::', '')
    end

    def resource_path_part
      self.class.resource_path_part
    end
  end
end
