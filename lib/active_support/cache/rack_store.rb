require 'active_support/cache'
require 'active_support/cache/memory_store'
require 'active_support/core_ext/module/delegation'
require 'rack/store'

module ActiveSupport
  module Cache
    class RackStore < Store
      RACK_STORE_ENV_KEY = 'rack_store.cache'

      delegate :clear, :cleanup, :prune, :pruning?,
        :inspect, :increment, :decrement,
        :delete_matched, :synchronize,
        :read, :write, :fetch, :to => :store

      def initialize(*options)
        @cache_store_options = options
      end

      def store
        Rack::Store.env[RACK_STORE_ENV_KEY] ||= ActiveSupport::Cache::MemoryStore.new *@cache_store_options
      end
    end
  end
end
