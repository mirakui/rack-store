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
        unless @env.has_key?(Thread.current.object_id)
          ObjectSpace.define_finalizer Thread.current, lambda {|thread_id| @env.delete thread_id }
        end
        @env[Thread.current.object_id] = env
      end
    end
  end
end
