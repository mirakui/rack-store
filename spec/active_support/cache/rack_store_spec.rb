require 'active_support/cache/rack_store'
require 'rack/store'
require 'rack/mock'
require 'rack/lint'

describe ActiveSupport::Cache::RackStore do
  describe 'lookup store' do
    subject { ActiveSupport::Cache.lookup_store :rack_store }
    it { should be_a ActiveSupport::Cache::RackStore }
  end

  describe 'read/write cache' do
    def request(url)
      app.call Rack::MockRequest.env_for(url)
    end

    before(:all) do
      @store = ActiveSupport::Cache.lookup_store :rack_store
    end

    let(:base_app) {
      lambda {|env|
        @store.fetch('count') { 0 }
        @store.increment('count')
        [200, {'Content-Type' => 'text/plain'}, 'OK']
      }
    }
    let(:app) { Rack::Lint.new Rack::Store.new(base_app) }

    describe 'env["rack_store.cache"]' do
      before do
        request('/')
      end
      subject { Rack::Store.env['rack_store.cache'] }
      it { should be_a ActiveSupport::Cache::MemoryStore }
    end

    it 'should be cleared each request' do
      request('/')
      @store.read('count').should == 1
      request('/')
      @store.read('count').should == 1
    end
  end
end
