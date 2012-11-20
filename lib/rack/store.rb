module Rack
  class Store
    def initialize(app)
      @app = app
    end

    def call(env)
      self.class.env = env
      self.class.cache = {}
      @app.call(env)
    end

    class << self
      def env
        @env ||= {}
      end

      def env=(env)
        @env = env
      end

      def cache
        @cache ||= {}
      end

      def cache=(cache)
        @cache = cache
      end
    end
  end
end
