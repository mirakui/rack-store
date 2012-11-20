require 'rack/store'
require 'rack/mock'
require 'rack/lint'

describe Rack::Store do
  let(:base_app) { lambda {|env| [200, {'Content-Type' => 'text/plain'}, 'HELLO'] } }
  let(:app) { Rack::Lint.new Rack::Store.new(base_app) }
  let(:request) { Rack::MockRequest.env_for }

  describe do
    subject { app.call(request) }
    its([0]) { should == 200 }
  end
end
