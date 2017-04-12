require 'spec_helper'

describe Zoomba::Base do
  describe '#assign' do
    subject { Zoomba::Base.new(foo: 'bar', id: 'some_id') }

    before { subject.assign(foo: 'baz', name: 'smith', id: 'some_other_id') }

    it { expect(subject.to_h).to eq(foo: 'baz', name: 'smith', id: 'some_id') }
  end

  context 'class method' do
    describe '#resource_path_part' do
      it { expect(Zoomba::Base.resource_path_part).to eq 'base' }
    end

    describe '#process_response' do
      let(:valid_response) do
        OpenStruct.new(code: '200', body: { foo: 'bar' }.to_json)
      end

      let(:invalid_response) do
        OpenStruct.new(
          code: '200',
          body: { error: { message: 'message', code: '123' } }.to_json
        )
      end

      context 'when http response code == 200' do
        context 'and response contains an error' do
          it do
            expect { Zoomba::Base.process_response(invalid_response) }
              .to raise_error(Zoomba::Error::ApiError)
          end
        end

        context 'when response is successful' do
          subject { Zoomba::Base.process_response(valid_response) }
          it { is_expected.to eq('foo' => 'bar') }
        end
      end

      context 'when http response code != 200' do
        let(:response) { OpenStruct.new(code: '123') }
        subject { Zoomba::Base.process_response(response) }
        it { is_expected.to eq nil }
      end
    end

    describe '#perform_request' do
      before do
        stub_request(:post, 'https://api.zoom.us/v1/base/some_action')
          .with(
            body: { api_key: 'API_KEY', api_secret: 'API_SECRET', foo: 'bar' },
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type' => 'application/x-www-form-urlencoded',
              'Host' => 'api.zoom.us', 'User-Agent' => 'Ruby'
            }
          ).to_return(status: 200, body: { response: 'success' }.to_json)
      end

      specify do
        expect(Zoomba::Base.perform_request(:some_action, foo: 'bar'))
          .to eq('response' => 'success')
      end
    end
  end
end
