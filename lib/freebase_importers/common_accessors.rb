module FreebaseImporters
  module CommonAccessors
    class << self
      def single(key)
        -> { data[key.to_s] }
      end

      def deep(key, internal_key)
        -> { data[key.to_s].collect {|d| d[internal_key.to_s] } }
      end

      def deep_singular(key, internal_key)
        -> { data[key.to_s].collect {|d| d[internal_key.to_s] }.first }
      end
    end
  end
end
