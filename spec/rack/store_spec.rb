require 'rack/store'
require 'rack/mock'
require 'rack/lint'

describe Rack::Store do
  let(:base_app) do
    lambda do |env|
      Rack::Store.cache['cache1'] = env['QUERY_STRING']
      [200, {'Content-Type' => 'text/plain'}, 'HELLO']
    end
  end
  let(:app) { Rack::Lint.new Rack::Store.new(base_app) }

  def request(url)
    app.call Rack::MockRequest.env_for(url)
  end

  describe '#env' do
    before { request '/hello?key=value' }
    subject { Rack::Store.env }
    its(['PATH_INFO']) { should == '/hello' }
    its(['QUERY_STRING']) { should == 'key=value' }
  end

  describe '#cache' do
    before { request '/hello?key=value' }
    subject { Rack::Store.cache }
    its(['cache1']) { should == 'key=value' }
  end

  context 'called twice' do
    before do
      request '/hello?key=value1'
      request '/hello?key=value2'
    end
    it { Rack::Store.env['QUERY_STRING'] == 'key=value2' }
    it { Rack::Store.cache['cache1'] == 'key=value2' }
  end
end
