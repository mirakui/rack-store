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
        @env[Thread.current.object_id] ||= {}
      end

      def env=(env)
        @env ||= {}
        @env[Thread.current.object_id] = env
      end
    end
  end
end
