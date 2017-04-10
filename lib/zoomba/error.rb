module Zoomba
  module Error
    class NoConfiguration < StandardError
      def initialize(msg = 'Please provide Zoom.us credentials.')
        super
      end
    end

    class RequiredParametersMissing < StandardError
      def initialize(*params)
        super("Api parameters are missing (#{params.join(', ')})")
      end
    end

    class ApiError < StandardError
      attr_reader :code
      def initialize(msg = 'Zoom API error', code = nil)
        @code = code
        super(msg)
      end
    end
  end
end
