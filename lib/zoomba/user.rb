module Zoomba
  class User < Zoomba::Base
    class << self
      def create(args = {})
        validate_params(args, :email, :type)
        new(perform_request(:create, args))
      end

      def autocreate(args = {})
        validate_params(args, :email, :type, :password)
        new(perform_request(:autocreate, args))
      end

      def custcreate(args = {})
        validate_params(args, :email, :type)
        new(perform_request(:custcreate, args))
      end

      def ssocreate(args = {})
        validate_params(args, :email, :type)
        new(perform_request(:ssocreate, args))
      end

      def delete(args = {})
        validate_params(args, :id)
        new(perform_request(:delete, args))
      end

      def deactivate(args = {})
        validate_params(args, :id)
        new(perform_request(:deactivate, args))
      end

      def get(id)
        new(perform_request(:get, id: id))
      end

      def list
        Zoomba::Collection.new(perform_request(:list), :users)
      end

      private

      def validate_params(params = {}, *expected)
        missing = expected - (params.keys & expected)
        raise Zoomba::Error::RequiredParametersMissing, missing if missing.any?
      end
    end
  end
end
