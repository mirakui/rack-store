module Rack
  class Store
    def initialize(app)
      @app = app
    end

    def call(env)
      self.class.env = env
      @app.call(env)
    end

    class << self
      def env
        @env ||= {}
      end

      def env=(env)
        @env = env
      end
    end
  end
end
