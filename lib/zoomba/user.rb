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

      def list(args = {})
        Zoomba::Collection.new(perform_request(:list, args), :users)
      end

      def pending(args = {})
        Zoomba::Collection.new(perform_request(:pending, args), :users)
      end

      def get(args = {})
        validate_params(args, :id)
        new(perform_request(:get, args))
      end

      def getbyemail(args = {})
        validate_params(args, :email, :login_type)
        new(perform_request(:getbyemail, args))
      end

      def checkemail(args = {})
        validate_params(args, :email)
        response = perform_request(:checkemail, args)
        response['existed_email']
      end

      def checkzpk(args = {})
        validate_params(args, :zpk)
        response = perform_request(:checkzpk, args)
        response['expire_in']
      end

      def validate_params(params = {}, *expected)
        missing = []
        expected.each do |param|
          missing << param if params[param].nil? || params[param].empty?
        end
        raise Zoomba::Error::RequiredParametersMissing, missing if missing.any?
      end
    end

    def delete
      validate_presence_of :id
      assign(perform_request(:delete, id: id))
    end

    def deactivate
      validate_presence_of :id
      assign(perform_request(:deactivate, id: id))
    end

    def update(args = {})
      validate_presence_of :id
      assign(args)
      assign(perform_request(:update, args.merge(id: id)))
    end

    def updatepassword(args = {})
      validate_params(args.merge(id: id), :id, :password)
      assign(perform_request(:updatepassword, args.merge(id: id)))
    end

    def revoketoken
      validate_presence_of :id
      assign(perform_request(:revoketoken, id: id))
    end

    def permanentdelete
      validate_presence_of :id
      assign(perform_request(:permanentdelete, id: id))
    end

    def get
      validate_presence_of :id
      assign(perform_request(:get, id: id))
    end

    private

    def validate_presence_of(param)
      if send(param).nil? || send(param).empty?
        raise Zoomba::Error::RequiredParametersMissing, [param]
      end
    end
  end
end
