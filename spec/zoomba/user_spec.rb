require "spec_helper"

describe Zoomba::User do
  let(:class_api_methods) do
    api_methods_returning_instance + %i(checkemail checkzpk)
  end

  let(:api_methods_returning_instance) do
    %i(create autocreate custcreate ssocreate get getbyemail)
  end

  let(:api_instance_methods) do
    %i(delete deactivate update updatepassword revoketoken permanentdelete get)
  end

  context 'class methods' do
    let(:params) { { foo: 'bar' }  }

    context 'calling any class api method' do

      before do
        expect(Zoomba::User).to receive(:validate_params)
                                  .exactly(class_api_methods.size).times
        expect(Zoomba::User).to receive(:perform_request)
                                  .and_return({attribute: 'value'})
                                  .exactly(class_api_methods.size).times
      end

      specify 'always call validate_params' do
        class_api_methods.each do |method|
          Zoomba::User.send(method, params)
        end
      end
    end

    context 'calling api methods returning resource attributes' do
      before do
        expect(Zoomba::User)
          .to receive(:validate_params)
                .exactly(api_methods_returning_instance.size).times
        expect(Zoomba::User)
          .to receive(:perform_request)
                .and_return({attribute: 'value'})
                .exactly(api_methods_returning_instance.size).times
      end

      specify 'create a class instance' do
        api_methods_returning_instance.each do |method|
          user = Zoomba::User.send(method, params)
          expect(user.class).to eq Zoomba::User
          expect(user.attribute).to eq 'value'
        end
      end
    end

    describe '#validate_params' do
      context 'when required params are present' do
        specify do
          expect { Zoomba::User.validate_params({foo: 'bar'}, :foo) }
            .not_to raise_error
        end
      end

      context 'when required params are missing' do
        specify do
          expect { Zoomba::User.validate_params({}, :foo) }
            .to raise_error(Zoomba::Error::RequiredParametersMissing)
        end
      end
    end
  end
end