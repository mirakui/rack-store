require 'rack/store'
require 'rack/mock'
require 'rack/lint'

describe Rack::Store do
  let(:base_app) do
    lambda do |env|
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

  context 'called twice' do
    before do
      request '/hello?key=value1'
      request '/hello?key=value2'
    end
    it { Rack::Store.env['QUERY_STRING'].should == 'key=value2' }
  end

  context 'multithread' do
    before do
      request '/hello?key=value'
      Thread.new { request '/hello?key=value2' }.join
    end
    subject { Rack::Store.env }
    it { Rack::Store.env['QUERY_STRING'].should == 'key=value' }
    it do
      GC.start
      Rack::Store.instance_variable_get(:@env).keys.length.should == 1
    end
  end
end
