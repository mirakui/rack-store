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
        if !@env.has_key?(Thread.current.object_id) && Thread.current != Thread.main
          ObjectSpace.define_finalizer(Thread.current) do
            @env.delete thread_id
          end
        end
        @env[Thread.current.object_id] = env
      end

      def cleanup_garbage_keys
        living_thread_ids = Thread.list.map(&:object_id)
        @env.delete_if do |thread_id, value|
          !living_thread_ids.include?(thread_id)
        end
      end
    end
  end
end
